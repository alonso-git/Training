import 'package:isar/isar.dart';

part 'exercise_model.g.dart';

@collection
class ExerciseModel {
    Id autoId = Isar.autoIncrement;

    @Index(type: IndexType.value)
    late String docId;

    late String name;

    @Index(type: IndexType.value)
    late String muscleGroup;

    late int sets;
    late int minReps;
    late int maxReps;
    late double weightIncrement;
    late bool isCustom;
}
