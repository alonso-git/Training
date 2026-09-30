import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:my_app/data/models/exercise_model.dart';
import 'package:my_app/data/models/routine_model.dart';
import 'package:my_app/data/models/session_model.dart';
import 'package:my_app/data/repositories/isar_exercise_repository.dart';
import 'package:my_app/data/repositories/isar_routine_repository.dart';
import 'package:my_app/data/repositories/isar_session_repository.dart';
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
    late IsarExerciseRepository exercises;
    late IsarRoutineRepository routines;
    late IsarSessionRepository sessions;

    setUpAll(() async {
        await Isar.initializeIsarCore(download: true);
    });

    setUp(() async {
        tempDir = Directory.systemTemp.createTempSync('nuthy_test');
        PathProviderPlatform.instance = FakePathProviderPlatform(tempDir);
        isar = await Isar.open(
            [
                ExerciseModelSchema,
                RoutineModelSchema,
                SessionModelSchema,
            ],
            directory: tempDir.path,
            name: 'test-${DateTime.now().microsecondsSinceEpoch}',
        );
        exercises = IsarExerciseRepository(isar);
        routines = IsarRoutineRepository(isar);
        sessions = IsarSessionRepository(isar);
    });

    tearDown(() async {
        await isar.writeTxn(() => isar.clear());
        await isar.close();
        tempDir.deleteSync(recursive: true);
    });

    test('exercise repository save/read/update/delete', () async {
        const exercise = Exercise(
            id: 'ex1',
            name: 'Bench Press',
            muscleGroup: 'chest',
            sets: 4,
            minReps: 8,
            maxReps: 12,
            weightIncrement: 2.5,
            isCustom: false,
        );
        await exercises.save(exercise);
        final loaded = await exercises.getById('ex1');
        expect(loaded, isNotNull);
        expect(loaded!.name, 'Bench Press');
        expect(loaded.weightIncrement, 2.5);

        await exercises.save(exercise.copyWith(sets: 5));
        final updated = await exercises.getById('ex1');
        expect(updated!.sets, 5);

        await exercises.delete('ex1');
        expect(await exercises.getById('ex1'), isNull);
    });

    test('existsByName is case-insensitive', () async {
        const exercise = Exercise(
            id: 'ex2',
            name: 'Squat',
            muscleGroup: 'quads',
            sets: 3,
            minReps: 6,
            maxReps: 10,
            weightIncrement: 5.0,
            isCustom: false,
        );
        await exercises.save(exercise);
        expect(await exercises.existsByName('squat'), isTrue);
        expect(await exercises.existsByName('SQUAT'), isTrue);
        expect(await exercises.existsByName('Press'), isFalse);
    });

    test('getByIds preserves caller order', () async {
        await exercises.save(_exercise('a'));
        await exercises.save(_exercise('b'));
        await exercises.save(_exercise('c'));
        final result = await exercises.getByIds(['c', 'a']);
        expect(result.map((e) => e.id).toList(), ['c', 'a']);
    });

    test('routine repository round-trip', () async {
        const routine = Routine(
            id: 'r1',
            name: 'Push day',
            dayOfWeek: [1, 3, 5],
            exerciseIds: ['a', 'b'],
        );
        await routines.save(routine);
        final loaded = await routines.getById('r1');
        expect(loaded!.name, 'Push day');
        expect(loaded.dayOfWeek, [1, 3, 5]);
        expect(await routines.getAll().then((l) => l.length), 1);
        await routines.delete('r1');
        expect(await routines.getById('r1'), isNull);
    });

    test('session queries: latest, for exercise, since date', () async {
        final now = DateTime.now().toUtc();
        final earlier = now.subtract(const Duration(days: 7));
        await sessions.save(_session('s1', earlier, 'w1'));
        await sessions.save(_session('s2', now, 'w1'));
        await sessions.save(_session('s3', now, 'w2'));

        final latest = await sessions.getLatestForExercise('w1');
        expect(latest!.id, 's2');

        final forW1 = await sessions.getForExercise('w1');
        expect(forW1.map((s) => s.id).toList(), ['s2', 's1']);

        final recent = await sessions.getSince(earlier.add(const Duration(hours: 1)));
        expect(recent.map((s) => s.id).toSet(), {'s2', 's3'});
    });

    test('routine isOnWeekday maps weekday % 7 (Mon=1…Sun=0)', () async {
        const routine = Routine(
            id: 'r2',
            name: 'Legs',
            dayOfWeek: [1],
            exerciseIds: [],
        );
        expect(routine.isOnWeekday(DateTime(2026, 9, 28)), isTrue);
        expect(routine.isOnWeekday(DateTime(2026, 9, 29)), isFalse);
    });

    test('session volume and totals compute correctly', () async {
        final s = _session('v1', DateTime.now().toUtc(), 'w1');
        expect(s.totalSets, 4);
        expect(s.volume, closeTo(28 * 4.0 + 60 * 3.0, 0.001));
    });
}

Exercise _exercise(String id) {
    return Exercise(
        id: id,
        name: 'Exercise $id',
        muscleGroup: 'chest',
        sets: 3,
        minReps: 8,
        maxReps: 12,
        weightIncrement: 2.5,
        isCustom: false,
    );
}

Session _session(String id, DateTime date, String exerciseId) {
    return Session(
        id: id,
        routineId: 'r1',
        routineName: 'Push day',
        date: date,
        duration: const Duration(minutes: 30),
        exerciseLogs: [
            ExerciseLog(
                exerciseId: exerciseId,
                weight: 4.0,
                sets: const [
                    SetLog(reps: 10),
                    SetLog(reps: 10),
                    SetLog(reps: 8),
                ],
            ),
            ExerciseLog(
                exerciseId: 'w2',
                weight: 60.0,
                sets: const [SetLog(reps: 3)],
            ),
        ],
    );
}