import 'package:signals/signals.dart';

import '../../data/services/workout_service.dart';
import '../../domain/entities/profile.dart';

/// App-wide reactive profile state. Screens read this to personalize
/// greetings, training-day widgets, and to drive the AMOLED / theme mode.
class ProfileState {
    ProfileState._();

    static final profile = signal<Profile>(Profile.defaultProfile());
    static final loading = signal<bool>(false);

    /// Loads the profile from the database into the signal. Safe to call
    /// repeatedly (screens call this in initState).
    static Future<void> load() async {
        final repository = AppServices.instance.profiles;
        loading.value = true;
        profile.value = await repository.get();
        loading.value = false;
    }

    /// Persists the profile and refreshes all listeners (including the
    /// MaterialApp theme).
    static Future<void> save(Profile updated) async {
        final repository = AppServices.instance.profiles;
        profile.value = updated;
        await repository.save(updated);
        profile.value = await repository.get();
    }
}
