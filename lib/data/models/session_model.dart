import 'package:isar/isar.dart';

part 'session_model.g.dart';

@embedded
class ExerciseLogModel {
    late String exerciseId;
    late double weight;
    List<int> setReps = [];
}

@collection
class SessionModel {
    Id autoId = Isar.autoIncrement;

    @Index(type: IndexType.value, unique: true, replace: false)
    late String docId;

    @Index(type: IndexType.value)
    late String routineId;

    late String routineName;

    @Index()
    late int dateUtcMs;

    late int durationSeconds;
    List<ExerciseLogModel> exerciseLogs = [];
}
