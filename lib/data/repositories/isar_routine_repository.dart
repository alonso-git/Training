import 'package:isar/isar.dart';

import '../../domain/entities/routine.dart';
import '../../domain/repositories/routine_repository.dart';
import '../models/routine_model.dart';

class IsarRoutineRepository implements RoutineRepository {
    IsarRoutineRepository(this._db);

    final Isar _db;

    static RoutineModel _toModel(Routine r) {
        return RoutineModel()
            ..docId = r.id
            ..name = r.name
            ..dayOfWeek = r.dayOfWeek
            ..exerciseIds = r.exerciseIds;
    }

    static Routine _fromModel(RoutineModel m) {
        return Routine(
            id: m.docId,
            name: m.name,
            dayOfWeek: List<int>.from(m.dayOfWeek),
            exerciseIds: List<String>.from(m.exerciseIds),
        );
    }

    @override
    Future<List<Routine>> getAll() async {
        final models = await _db.routineModels.where().findAll();
        final list = models.map(_fromModel).toList()
            ..sort((a, b) => a.name.compareTo(b.name));
        return list;
    }

    @override
    Future<Routine?> getById(String id) async {
        final model = await _db.routineModels.filter().docIdEqualTo(id).findFirst();
        return model == null ? null : _fromModel(model);
    }

    @override
    Future<void> save(Routine routine) async {
        await _db.writeTxn(() async {
            final existing = await _db.routineModels
                .filter()
                .docIdEqualTo(routine.id)
                .findFirst();
            final model = _toModel(routine);
            model.autoId = existing?.autoId ?? Isar.autoIncrement;
            await _db.routineModels.put(model);
        });
    }

    @override
    Future<void> delete(String id) async {
        await _db.writeTxn(() async {
            final existing = await _db.routineModels
                .filter()
                .docIdEqualTo(id)
                .findFirst();
            if (existing != null) {
                await _db.routineModels.delete(existing.autoId);
            }
        });
    }
}
