import 'package:signals/signals.dart';

import '../../data/services/database_service.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/exercise_log.dart';
import '../../domain/entities/routine.dart';
import '../../domain/entities/session.dart';
import '../../domain/repositories/exercise_repository.dart';
import '../../domain/repositories/routine_repository.dart';
import '../../domain/repositories/session_repository.dart';

/// Small locator that exposes domain repositories once the database is ready.
class AppServices {
    AppServices._(this.database);

    static AppServices? _instance;

    final DatabaseService database;

    late final ExerciseRepository exercises = database.exercises;
    late final RoutineRepository routines = database.routines;
    late final SessionRepository sessions = database.sessions;

    static AppServices get instance {
        final instance = _instance;
        if (instance == null) {
            throw StateError('AppServices.init() has not been called yet');
        }
        return instance;
    }

    static Future<void> init(DatabaseService database) async {
        await database.init();
        _instance ??= AppServices._(database);
    }

    static void reset() {
        _instance = null;
    }
}

/// Domain service resolving weights, weight suggestions, and session saving.
class WorkoutService {
    WorkoutService({AppServices? services}) {
        final app = services ?? AppServices.instance;
        _routines = app.routines;
        _exercises = app.exercises;
        _sessions = app.sessions;
    }

    late final RoutineRepository _routines;
    late final ExerciseRepository _exercises;
    late final SessionRepository _sessions;

    int _idCounter = 0;

    Future<List<Routine>> listRoutines() {
        return _routines.getAll();
    }

    Future<List<Exercise>> listExercises() {
        return _exercises.getAll();
    }

    Future<bool> exerciseExistsByName(String name) {
        return _exercises.existsByName(name);
    }

    Future<void> saveRoutine(Routine routine) async {
        if (routine.name.trim().isEmpty) {
            throw ArgumentError('Routine name is required');
        }
        await _routines.save(routine);
    }

    Future<void> deleteRoutine(String routineId) async {
        await _routines.delete(routineId);
    }

    Future<void> saveExercise(Exercise exercise) async {
        if (exercise.name.trim().isEmpty) {
            throw ArgumentError('Exercise name is required');
        }
        await _exercises.save(exercise);
    }

    Future<Exercise?> findExercise(String exerciseId) {
        return _exercises.getById(exerciseId);
    }

    Future<Routine?> findRoutine(String routineId) {
        return _routines.getById(routineId);
    }

    Future<List<Exercise>> exercisesForRoutine(Routine routine) async {
        return _exercises.getByIds(routine.exerciseIds);
    }

    Future<List<Session>> sessionsList() {
        return _sessions.getAll();
    }

    Future<List<Session>> sessionsForExercise(String exerciseId) {
        return _sessions.getForExercise(exerciseId);
    }

    Future<void> deleteSession(String id) async {
        await _sessions.delete(id);
    }

    /// Builds starting state for one exercise: auto-filled weight from the
    /// last session, plus a next-week suggestion when the user reached the
    /// exercise's target max reps in any session this week.
    Future<ExerciseStartState> prepareExercise(String exerciseId) async {
        final exercise = await _exercises.getById(exerciseId);
        if (exercise == null) {
            throw StateError('Unknown exercise: $exerciseId');
        }
        final lastSession = await _sessions.getLatestForExercise(exerciseId);
        var lastWeight = 0.0;
        if (lastSession != null) {
            for (final log in lastSession.exerciseLogs) {
                if (log.exerciseId == exerciseId) {
                    lastWeight = log.weight;
                }
            }
        }

        final weekStart = startOfWeek(DateTime.now());
        final weekSessions = await _sessions.getSince(weekStart);
        var reachedMaxThisWeek = false;
        for (final session in weekSessions) {
            for (final log in session.exerciseLogs) {
                if (log.exerciseId == exerciseId &&
                    log.maxReps >= exercise.maxReps) {
                    reachedMaxThisWeek = true;
                }
            }
        }

        return ExerciseStartState(
            exercise: exercise,
            suggestedWeight: reachedMaxThisWeek
                ? exercise.weightIncrement + lastWeight
                : lastWeight,
            lastWeight: lastWeight,
            hasSuggestion: reachedMaxThisWeek,
        );
    }

    /// Saves a completed session and returns its summary data.
    Future<CompletedSession> saveSession(
        String routineId,
        Duration duration,
        List<ExerciseLog> logs,
    ) async {
        if (logs.isEmpty) {
            throw ArgumentError('A session must include at least one exercise');
        }
        for (final log in logs) {
            if (log.sets.isEmpty) {
                throw ArgumentError('Each logged exercise must include sets');
            }
        }
        final routine = await _routines.getById(routineId);
        final routineName = routine?.name ?? '';
        final session = Session(
            id: newSessionId(),
            routineId: routineId,
            routineName: routineName,
            date: DateTime.now(),
            duration: duration,
            exerciseLogs: logs,
        );
        await _sessions.save(session);
        return CompletedSession(
            id: session.id,
            routineName: routineName,
            duration: duration,
            exerciseLogs: logs,
        );
    }

    String newSessionId() {
        _idCounter++;
        return '${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}'
            '-$_idCounter';
    }

    String newExerciseId() {
        _idCounter++;
        return 'ex-${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}'
            '-$_idCounter';
    }

    static DateTime startOfWeek(DateTime dt) {
        final day = dt.weekday - 1;
        return DateTime(dt.year, dt.month, dt.day - day);
    }
}

/// Summary returned after a session is saved.
class CompletedSession {
    const CompletedSession({
        required this.id,
        required this.routineName,
        required this.duration,
        required this.exerciseLogs,
    });

    final String id;
    final String routineName;
    final Duration duration;
    final List<ExerciseLog> exerciseLogs;

    double get volume {
        var total = 0.0;
        for (final log in exerciseLogs) {
            total += log.volume;
        }
        return total;
    }

    int get totalSets {
        var total = 0;
        for (final log in exerciseLogs) {
            total += log.sets.length;
        }
        return total;
    }
}

/// Starting state for an exercise inside the session flow.
class ExerciseStartState {
    const ExerciseStartState({
        required this.exercise,
        required this.suggestedWeight,
        required this.lastWeight,
        required this.hasSuggestion,
    });

    final Exercise exercise;
    final double suggestedWeight;
    final double lastWeight;
    final bool hasSuggestion;
}

/// Reactive bundle of repositories lists shared between screens.
class DataHub {
    DataHub._(
        this._routines,
        this._exercises,
        this._sessions,
    );

    static DataHub? _instance;

    final RoutineRepository _routines;
    final ExerciseRepository _exercises;
    final SessionRepository _sessions;

    final routines = signal<List<Routine>>(const []);
    final exercises = signal<List<Exercise>>(const []);
    final sessions = signal<List<Session>>(const []);
    final loading = signal<bool>(false);

    static DataHub get instance {
        final instance = _instance;
        if (instance == null) {
            throw StateError('DataHub.refresh() has not been called yet');
        }
        return instance;
    }

    static Future<DataHub> refresh(AppServices app) async {
        _instance ??= DataHub._(app.routines, app.exercises, app.sessions);
        await _instance!._reload();
        return _instance!;
    }

    Future<void> _reload() async {
        loading.value = true;
        final r = await _routines.getAll();
        final e = await _exercises.getAll();
        final s = await _sessions.getAll();
        routines.value = r;
        exercises.value = e;
        sessions.value = s;
        loading.value = false;
    }

    Future<List<Routine>> routinesForDay(DateTime dt) async {
        final all = await _routines.getAll();
        return all.where((r) => r.isOnWeekday(dt)).toList();
    }
}
