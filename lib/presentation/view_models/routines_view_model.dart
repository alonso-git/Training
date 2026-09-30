import 'dart:math' as math;

import 'package:signals/signals.dart';

import '../../data/services/workout_service.dart';
import '../../domain/entities/routine.dart';

/// State for the routines list screen.
class RoutinesViewModel {
    RoutinesViewModel(this._workout);

    final WorkoutService _workout;

    final routines = signal<List<Routine>>(const []);
    final loading = signal<bool>(true);

    Future<void> load() async {
        loading.value = true;
        routines.value = await _workout.listRoutines();
        loading.value = false;
    }

    Future<void> deleteRoutine(String id) async {
        await _workout.deleteRoutine(id);
        await load();
    }

    Routine newDraft() {
        final seed = math.Random().nextInt(1 << 32).toRadixString(36);
        return Routine(
            id: 'r-$seed',
            name: '',
            dayOfWeek: const [],
            exerciseIds: const [],
        );
    }
}
