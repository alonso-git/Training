import 'package:signals/signals.dart';

import '../../data/services/workout_service.dart';
import '../../domain/entities/exercise.dart';

/// State for the exercise picker: catalog browsing plus custom creation.
class ExercisePickerViewModel {
    ExercisePickerViewModel(this._workout);

    final WorkoutService _workout;

    final exercises = signal<List<Exercise>>(const []);
    final query = signal<String>('');
    final loading = signal<bool>(true);

    final selectedMuscleGroup = signal<String?>(null);

    Future<void> load() async {
        loading.value = true;
        final all = await _workout.listExercises();
        exercises.value = all;
        loading.value = false;
    }

    Future<void> refresh() async {
        final all = await _workout.listExercises();
        exercises.value = all;
    }

    void setQuery(String value) {
        query.value = value;
    }

    void setMuscleGroupFilter(String? value) {
        selectedMuscleGroup.value = value;
    }

    List<Exercise> filtered() {
        final q = query.value.trim().toLowerCase();
        final muscle = selectedMuscleGroup.value;
        return exercises.value.where((e) {
            final matchesQuery = q.isEmpty || e.name.toLowerCase().contains(q);
            final matchesMuscle = muscle == null || e.muscleGroup == muscle;
            return matchesQuery && matchesMuscle;
        }).toList();
    }

    /// Saves a custom exercise and returns its id.
    Future<String> createCustom(Exercise exercise) async {
        final id = _workout.newExerciseId();
        await _workout.saveExercise(exercise.copyWith(id: id, isCustom: true));
        exercises.value = await _workout.listExercises();
        return id;
    }
}
