import 'package:isar/isar.dart';

import '../../domain/entities/exercise.dart';
import '../../domain/repositories/exercise_repository.dart';
import '../models/exercise_model.dart';

class IsarExerciseRepository implements ExerciseRepository {
    IsarExerciseRepository(this._db);

    final Isar _db;

    static ExerciseModel _toModel(Exercise e) {
        return ExerciseModel()
            ..docId = e.id
            ..name = e.name
            ..muscleGroup = e.muscleGroup
            ..sets = e.sets
            ..minReps = e.minReps
            ..maxReps = e.maxReps
            ..weightIncrement = e.weightIncrement
            ..isCustom = e.isCustom
            ..restSeconds = e.restSeconds;
    }

    static Exercise _fromModel(ExerciseModel m) {
        return Exercise(
            id: m.docId,
            name: m.name,
            muscleGroup: m.muscleGroup,
            sets: m.sets,
            minReps: m.minReps,
            maxReps: m.maxReps,
            weightIncrement: m.weightIncrement,
            isCustom: m.isCustom,
            // Legacy rows (null) carry no rest preference: fall back to the
            // project default. A stored 0 means the user opted out.
            restSeconds: m.restSeconds ?? defaultRestSeconds,
        );
    }

    @override
    Future<List<Exercise>> getAll() async {
        final models = await _db.exerciseModels.where().findAll();
        final list = models.map(_fromModel).toList()
            ..sort((a, b) => a.name.compareTo(b.name));
        return list;
    }

    @override
    Future<Exercise?> getById(String id) async {
        final model = await _db.exerciseModels
            .filter()
            .docIdEqualTo(id)
            .findFirst();
        return model == null ? null : _fromModel(model);
    }

    @override
    Future<List<Exercise>> getByIds(List<String> ids) async {
        if (ids.isEmpty) {
            return [];
        }
        final idSet = Set<String>.from(ids);
        final all = await _db.exerciseModels.where().findAll();
        final list = all
            .where((m) => idSet.contains(m.docId))
            .map(_fromModel)
            .toList();
        list.sort((a, b) {
            final ia = ids.indexOf(a.id);
            final ib = ids.indexOf(b.id);
            return ia.compareTo(ib);
        });
        return list;
    }

    @override
    Future<void> save(Exercise exercise) async {
        await _db.writeTxn(() async {
            final existing = await _db.exerciseModels
                .filter()
                .docIdEqualTo(exercise.id)
                .findFirst();
            final model = _toModel(exercise);
            model.autoId = existing?.autoId ?? Isar.autoIncrement;
            await _db.exerciseModels.put(model);
        });
    }

    @override
    Future<void> delete(String id) async {
        await _db.writeTxn(() async {
            final existing = await _db.exerciseModels
                .filter()
                .docIdEqualTo(id)
                .findFirst();
            if (existing != null) {
                await _db.exerciseModels.delete(existing.autoId);
            }
        });
    }

    @override
    Future<bool> existsByName(String name) async {
        final model = await _db.exerciseModels
            .filter()
            .nameEqualTo(name, caseSensitive: false)
            .findFirst();
        return model != null;
    }
}
