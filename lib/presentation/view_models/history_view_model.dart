import 'package:signals/signals.dart';

import '../../data/services/workout_service.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/session.dart';

class HistoryViewModel {
    HistoryViewModel({WorkoutService? workout}) :
        _workout = workout ?? WorkoutService();

    final WorkoutService _workout;

    final sessions = signal<List<Session>>(const []);
    final loading = signal<bool>(true);

    final exerciseNames = signal<Map<String, String>>({});

    Future<void> load() async {
        loading.value = true;
        final all = await _workout.sessionsList();
        sessions.value = all;
        final names = <String, String>{};
        for (final exercise in await _workout.listExercises()) {
            names[exercise.id] = exercise.name;
        }
        exerciseNames.value = names;
        loading.value = false;
    }

    String exerciseName(String id) {
        return exerciseNames.value[id] ?? 'Exercise';
    }

    Future<void> deleteSession(String id) async {
        await _workout.deleteSession(id);
        await load();
    }
}

/// Loads the sessions belonging to one exercise for the detail screen.
class ExerciseDetailViewModel {
    ExerciseDetailViewModel({WorkoutService? workout}) :
        _workout = workout ?? WorkoutService();

    final WorkoutService _workout;

    final exercise = signal<Exercise?>(null);
    final sessions = signal<List<Session>>(const []);
    final loading = signal<bool>(true);

    Future<void> load(String exerciseId) async {
        loading.value = true;
        exercise.value = await _workout.findExercise(exerciseId);
        sessions.value = await _workout.sessionsForExercise(exerciseId);
        loading.value = false;
    }
}
