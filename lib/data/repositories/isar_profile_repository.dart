import 'package:isar/isar.dart';

import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/profile_model.dart';

class IsarProfileRepository implements ProfileRepository {
    IsarProfileRepository(this._db);

    final Isar _db;

    static ProfileModel _toModel(Profile p) {
        return ProfileModel()
            ..docId = p.id
            ..name = p.name
            ..trainingDays = p.trainingDays
            ..themeModeIndex = p.themeModeIndex
            ..amoled = p.amoled;
    }

    static Profile _fromModel(ProfileModel m) {
        return Profile(
            id: m.docId,
            name: m.name,
            trainingDays: List<int>.from(m.trainingDays),
            themeModeIndex: m.themeModeIndex,
            amoled: m.amoled,
        );
    }

    @override
    Future<Profile> get() async {
        final model = await _db.profileModels
            .filter()
            .docIdEqualTo(Profile.localId)
            .findFirst();
        return model == null ? Profile.defaultProfile() : _fromModel(model);
    }

    @override
    Future<void> save(Profile profile) async {
        await _db.writeTxn(() async {
            final existing = await _db.profileModels
                .filter()
                .docIdEqualTo(profile.id)
                .findFirst();
            final model = _toModel(profile);
            model.autoId = existing?.autoId ?? Isar.autoIncrement;
            await _db.profileModels.put(model);
        });
    }
}
