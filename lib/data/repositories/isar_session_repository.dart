import 'package:isar/isar.dart';

import '../../domain/entities/exercise_log.dart';
import '../../domain/entities/session.dart';
import '../../domain/entities/set_log.dart';
import '../../domain/repositories/session_repository.dart';
import '../models/session_model.dart';

class IsarSessionRepository implements SessionRepository {
    IsarSessionRepository(this._db);

    final Isar _db;

    static SessionModel _toModel(Session s) {
        return SessionModel()
            ..docId = s.id
            ..routineId = s.routineId
            ..routineName = s.routineName
            ..dateUtcMs = s.date.toUtc().millisecondsSinceEpoch
            ..durationSeconds = s.duration.inSeconds
            ..exerciseLogs = s.exerciseLogs
                .map(
                    (log) => ExerciseLogModel()
                        ..exerciseId = log.exerciseId
                        ..weight = log.weight
                        ..setReps = log.sets.map((set) => set.reps).toList(),
                )
                .toList();
    }

    static Session _fromModel(SessionModel m) {
        return Session(
            id: m.docId,
            routineId: m.routineId,
            routineName: m.routineName,
            date: DateTime.fromMillisecondsSinceEpoch(m.dateUtcMs, isUtc: true),
            duration: Duration(seconds: m.durationSeconds),
            exerciseLogs: m.exerciseLogs
                .map(
                    (log) => ExerciseLog(
                        exerciseId: log.exerciseId,
                        weight: log.weight,
                        sets: log.setReps
                            .map((reps) => SetLog(reps: reps))
                            .toList(),
                    ),
                )
                .toList(),
        );
    }

    @override
    Future<List<Session>> getAll() async {
        final models = await _db.sessionModels.where().findAll();
        final list = models.map(_fromModel).toList()
            ..sort((a, b) => b.date.compareTo(a.date));
        return list;
    }

    @override
    Future<Session?> getById(String id) async {
        final model = await _db.sessionModels.filter().docIdEqualTo(id).findFirst();
        return model == null ? null : _fromModel(model);
    }

    @override
    Future<Session?> getLatestForExercise(String exerciseId) async {
        final all = await getForExercise(exerciseId);
        return all.isEmpty ? null : all.first;
    }

    @override
    Future<List<Session>> getForExercise(String exerciseId) async {
        final models = await _db.sessionModels.where().findAll();
        final list = models
            .where(
                (m) => m.exerciseLogs.any(
                    (log) => log.exerciseId == exerciseId,
                ),
            )
            .map(_fromModel)
            .toList()
            ..sort((a, b) => b.date.compareTo(a.date));
        return list;
    }

    @override
    Future<List<Session>> getSince(DateTime date) async {
        final cutoff = date.toUtc().millisecondsSinceEpoch;
        final models = await _db.sessionModels.where().findAll();
        final list = models
            .where((m) => m.dateUtcMs > cutoff)
            .map(_fromModel)
            .toList()
            ..sort((a, b) => b.date.compareTo(a.date));
        return list;
    }

    @override
    Future<void> save(Session session) async {
        await _db.writeTxn(() async {
            final existing = await _db.sessionModels
                .filter()
                .docIdEqualTo(session.id)
                .findFirst();
            final model = _toModel(session);
            model.autoId = existing?.autoId ?? Isar.autoIncrement;
            await _db.sessionModels.put(model);
        });
    }

    @override
    Future<void> delete(String id) async {
        await _db.writeTxn(() async {
            final existing = await _db.sessionModels
                .filter()
                .docIdEqualTo(id)
                .findFirst();
            if (existing != null) {
                await _db.sessionModels.delete(existing.autoId);
            }
        });
    }
}
