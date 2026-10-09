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

    /// Suggested rest after each set, in seconds. Null = legacy row saved
    /// before this attribute existed (treated as no preference); 0 = the
    /// user explicitly disabled the rest timer; >0 = configured seconds.
    int? restSeconds;
}
