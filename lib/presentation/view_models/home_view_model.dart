import 'package:signals/signals.dart';

import '../../data/services/workout_service.dart';
import '../../domain/entities/routine.dart';

/// State for the home screen: routines assigned to today plus all routines
/// for manual start.
class HomeViewModel {
    HomeViewModel(this._workout);

    final WorkoutService _workout;

    final todayRoutines = signal<List<Routine>>(const []);
    final todayWeekday = signal<int>(DateTime.now().weekday % 7);
    final loading = signal<bool>(true);

    Future<void> load() async {
        loading.value = true;
        final now = DateTime.now();
        todayWeekday.value = now.weekday % 7;
        todayRoutines.value = await DataHub.instance.routinesForDay(now);
        loading.value = false;
    }

    Future<List<Routine>> allRoutines() {
        return _workout.listRoutines();
    }
}
