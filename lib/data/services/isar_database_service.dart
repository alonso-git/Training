import 'package:isar/isar.dart';

// ignore_for_file: unused_import
import 'package:isar_flutter_libs/isar_flutter_libs.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/repositories/exercise_repository.dart';
import '../../domain/repositories/routine_repository.dart';
import '../../domain/repositories/session_repository.dart';
import '../models/exercise_model.dart';
import '../models/routine_model.dart';
import '../models/session_model.dart';
import '../repositories/isar_exercise_repository.dart';
import '../repositories/isar_routine_repository.dart';
import '../repositories/isar_session_repository.dart';
import 'database_service.dart';
import 'exercise_catalog_seed.dart';

/// Isar-backed [DatabaseService] for native platforms.
class IsarDatabaseService implements DatabaseService {
    IsarDatabaseService({Isar? dbOverride}) : _dbOverride = dbOverride;

    final Isar? _dbOverride;
    Isar? _db;
    bool _initialized = false;
    ExerciseRepository? _exercises;
    RoutineRepository? _routines;
    SessionRepository? _sessions;

    static const String _instanceName = 'workout_tracker';

    @override
    ExerciseRepository get exercises {
        final db = _db;
        if (db == null) {
            throw StateError('DatabaseService not initialized');
        }
        return _exercises ??= IsarExerciseRepository(db);
    }

    @override
    RoutineRepository get routines {
        final db = _db;
        if (db == null) {
            throw StateError('DatabaseService not initialized');
        }
        return _routines ??= IsarRoutineRepository(db);
    }

    @override
    SessionRepository get sessions {
        final db = _db;
        if (db == null) {
            throw StateError('DatabaseService not initialized');
        }
        return _sessions ??= IsarSessionRepository(db);
    }

    @override
    Future<void> init() async {
        if (_initialized && _db != null) {
            return;
        }
        if (_dbOverride != null) {
            _db = _dbOverride;
            _exercises = IsarExerciseRepository(_db!);
            _routines = IsarRoutineRepository(_db!);
            _sessions = IsarSessionRepository(_db!);
            await _seedFromSpec();
            _initialized = true;
            return;
        }
        final dir = await getApplicationDocumentsDirectory();
        _db = await Isar.open(
            [
                ExerciseModelSchema,
                RoutineModelSchema,
                SessionModelSchema,
            ],
            directory: dir.path,
            name: _instanceName,
        );
        _exercises = IsarExerciseRepository(_db!);
        _routines = IsarRoutineRepository(_db!);
        _sessions = IsarSessionRepository(_db!);
        await _seedFromSpec();
        _initialized = true;
    }

    /// Seeds the predefined exercise catalog (skips names that already exist).
    Future<void> _seedFromSpec() async {
        for (final exercise in ExerciseCatalogSeed.catalog) {
            final exists = await exercises.existsByName(exercise.name);
            if (!exists) {
                await exercises.save(exercise);
            }
        }
    }

    @override
    Future<void> clearAll() async {
        await _db!.writeTxn(() async {
            await _db!.clear();
        });
        await _seedFromSpec();
    }

    @override
    Future<int> dataSizeBytes() {
        return Future.value(0);
    }
}
