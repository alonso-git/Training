import 'package:isar/isar.dart';

part 'routine_model.g.dart';

@collection
class RoutineModel {
    Id autoId = Isar.autoIncrement;

    @Index(type: IndexType.value, unique: true, replace: false)
    late String docId;

    late String name;
    late List<int> dayOfWeek;
    late List<String> exerciseIds;
}
