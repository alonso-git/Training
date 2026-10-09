import '../../domain/repositories/exercise_repository.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/repositories/routine_repository.dart';
import '../../domain/repositories/session_repository.dart';

abstract interface class DatabaseService {
    ExerciseRepository get exercises;
    RoutineRepository get routines;
    SessionRepository get sessions;
    ProfileRepository get profiles;
    Future<void> init();
    Future<void> clearAll();
    Future<int> dataSizeBytes();
}
