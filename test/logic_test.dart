import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:my_app/data/models/exercise_model.dart';
import 'package:my_app/data/models/routine_model.dart';
import 'package:my_app/data/models/session_model.dart';
import 'package:my_app/data/services/backup_service.dart';
import 'package:my_app/data/services/isar_database_service.dart';
import 'package:my_app/data/services/workout_service.dart';
import 'package:my_app/domain/entities/exercise.dart';
import 'package:my_app/domain/entities/exercise_log.dart';
import 'package:my_app/domain/entities/routine.dart';
import 'package:my_app/domain/entities/session.dart';
import 'package:my_app/domain/entities/set_log.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'fakes/fake_path_provider.dart';

void main() {
    late Directory tempDir;
    late Isar isar;
    late IsarDatabaseService database;
    late WorkoutService workout;
    late BackupService backup;

    setUpAll(() async {
        await Isar.initializeIsarCore(download: true);
    });

    setUp(() async {
        tempDir = Directory.systemTemp.createTempSync('nuthy_logic_test');
        PathProviderPlatform.instance = FakePathProviderPlatform(tempDir);
        isar = await Isar.open(
            [
                ExerciseModelSchema,
                RoutineModelSchema,
                SessionModelSchema,
            ],
            directory: tempDir.path,
            name: 'logic-${DateTime.now().microsecondsSinceEpoch}',
        );
        database = IsarDatabaseService(dbOverride: isar);
        await database.init();
        await AppServices.init(database);
        workout = WorkoutService();
        backup = BackupService(database);
    });

    tearDown(() async {
        AppServices.reset();
        await isar.writeTxn(() => isar.clear());
        await isar.close();
        tempDir.deleteSync(recursive: true);
    });

    Future<void> seedRoutine({String exerciseId = 'cat-bench-press'}) async {
        await database.exercises.save(
            Exercise(
                id: exerciseId,
                name: 'Bench Press',
                muscleGroup: 'chest',
                sets: 4,
                minReps: 8,
                maxReps: 12,
                weightIncrement: 2.5,
                isCustom: false,
            ),
        );
        await database.routines.save(
            Routine(
                id: 'r1',
                name: 'Push day',
                dayOfWeek: [1],
                exerciseIds: [exerciseId],
            ),
        );
    }

    test('prepareExercise: no history -> weight 0, no suggestion', () async {
        await seedRoutine();
        final state = await workout.prepareExercise('cat-bench-press');
        expect(state.lastWeight, 0.0);
        expect(state.hasSuggestion, isFalse);
        expect(state.suggestedWeight, 0.0);
    });

    test('prepareExercise: autofills weight from last session', () async {
        await seedRoutine();
        await database.sessions.save(
            Session(
                id: 's-prev',
                routineId: 'r1',
                routineName: 'Push day',
                date: DateTime.now().subtract(const Duration(days: 8)),
                duration: const Duration(minutes: 25),
                exerciseLogs: [
                    ExerciseLog(
                        exerciseId: 'cat-bench-press',
                        weight: 60.0,
                        sets: List<SetLog>.unmodifiable(
                            [10, 9, 8, 8].map((n) => SetLog(reps: n)),
                        ),
                    ),
                ],
            ),
        );
        final state = await workout.prepareExercise('cat-bench-press');
        expect(state.lastWeight, 60.0);
        expect(state.hasSuggestion, isFalse);
        expect(state.suggestedWeight, 60.0);
    });

    test('max reps reached this week -> suggests increment (60 -> 62.5)',
        () async {
        await seedRoutine();
        await database.sessions.save(
            Session(
                id: 's-hit',
                routineId: 'r1',
                routineName: 'Push day',
                date: DateTime.now(),
                duration: const Duration(minutes: 30),
                exerciseLogs: [
                    ExerciseLog(
                        exerciseId: 'cat-bench-press',
                        weight: 60.0,
                        sets: List<SetLog>.unmodifiable(
                            [12, 12, 10, 9].map((n) => SetLog(reps: n)),
                        ),
                    ),
                ],
            ),
        );
        final state = await workout.prepareExercise('cat-bench-press');
        expect(state.hasSuggestion, isTrue);
        expect(state.suggestedWeight, 62.5);
    });

    test('session flow saves and validates in HistoryView', () async {
        await seedRoutine();
        final state = await workout.prepareExercise('cat-bench-press');
        final saved = await workout.saveSession(
            'r1',
            const Duration(minutes: 32),
            [
                ExerciseLog(
                    exerciseId: state.exercise.id,
                    weight: 60.0,
                    sets: const [
                        SetLog(reps: 12),
                        SetLog(reps: 10),
                        SetLog(reps: 10),
                        SetLog(reps: 8),
                    ],
                ),
            ],
        );
        expect(saved.routineName, 'Push day');
        expect(saved.totalSets, 4);
        expect(saved.volume, closeTo(40 * 60.0, 0.01));
        final all = await database.sessions.getAll();
        expect(all, hasLength(1));
        expect(all.first.exerciseLogs.first.weight, 60.0);
        expect(all.first.exerciseLogs.first.maxReps, 12);
    });

    test('export produces JSON with all sections; import invalid leaves DB',
        () async {
        await seedRoutine();
        await database.sessions.save(Session(
            id: 's1',
            routineId: 'r1',
            routineName: 'Push day',
            date: DateTime.now(),
            duration: const Duration(minutes: 30),
            exerciseLogs: [
                ExerciseLog(
                    exerciseId: 'cat-bench-press',
                    weight: 60.0,
                    sets: List<SetLog>.unmodifiable(
                        [8, 8, 8].map((n) => SetLog(reps: n)),
                    ),
                ),
            ],
        ));

        final json = await backup.exportData();
        expect(json, contains('"routines"'));
        expect(json, contains('"exercises"'));
        expect(json, contains('"sessions"'));

        final invalid = '{not json';
        expect(BackupService.validateContents(invalid).isValid, isFalse);

        final valid = BackupService.validateContents(json);
        expect(valid.isValid, isTrue);
    });

    test('import replaces all data and re-seeds catalog', () async {
        await seedRoutine();
        final json = await backup.exportData();

        await database.routines.save(const Routine(
            id: 'newer',
            name: 'Newer routine',
            dayOfWeek: [0],
            exerciseIds: ['z'],
        ));
        expect(await database.routines.getAll().then((l) => l.length), 2);

        await backup.restoreFromFile(json);
        final routines = await database.routines.getAll();
        expect(routines.map((r) => r.id).toSet(), {'r1'});

        final seeded = await _findByName('Bench Press');
        expect(seeded, isNotNull);
    });

    test('import invalid JSON throws and database untouched', () async {
        await seedRoutine();
        final before = await database.routines.getAll();
        expect(
            () => backup.restoreFromFile('{bad json'),
            throwsFormatException,
        );
        final after = await database.routines.getAll();
        expect(after.map((r) => r.id), before.map((r) => r.id));
    });
}

Future<Exercise?> _findByName(String name) async {
    final all = await AppServices.instance.exercises.getAll();
    for (final e in all) {
        if (e.name == name) {
            return e;
        }
    }
    return null;
}
