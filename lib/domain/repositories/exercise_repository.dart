import '../entities/exercise.dart';

abstract interface class ExerciseRepository {
    Future<List<Exercise>> getAll();
    Future<Exercise?> getById(String id);
    Future<List<Exercise>> getByIds(List<String> ids);
    Future<void> save(Exercise exercise);
    Future<void> delete(String id);
    Future<bool> existsByName(String name);
}
