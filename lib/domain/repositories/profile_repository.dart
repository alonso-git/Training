import '../entities/profile.dart';

abstract interface class ProfileRepository {
    /// Returns the stored profile, or a default one when none exists yet.
    Future<Profile> get();

    Future<void> save(Profile profile);
}
