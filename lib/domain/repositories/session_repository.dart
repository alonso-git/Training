import '../entities/session.dart';

abstract interface class SessionRepository {
    Future<List<Session>> getAll();
    Future<Session?> getById(String id);
    Future<Session?> getLatestForExercise(String exerciseId);
    Future<List<Session>> getForExercise(String exerciseId);
    Future<List<Session>> getSince(DateTime date);
    Future<void> save(Session session);
    Future<void> delete(String id);
}
