import '../entities/routine.dart';

abstract interface class RoutineRepository {
    Future<List<Routine>> getAll();
    Future<Routine?> getById(String id);
    Future<void> save(Routine routine);
    Future<void> delete(String id);
}
