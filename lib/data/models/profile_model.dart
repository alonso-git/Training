import 'package:isar/isar.dart';

part 'profile_model.g.dart';

@collection
class ProfileModel {
    Id autoId = Isar.autoIncrement;

    @Index(type: IndexType.value, unique: true, replace: false)
    late String docId;

    late String name;
    late List<int> trainingDays;
    late int themeModeIndex;
    late bool amoled;
}
