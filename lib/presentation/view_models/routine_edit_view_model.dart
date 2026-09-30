import 'package:signals/signals.dart';

import '../../core/constants/muscle_groups.dart';
import '../../data/services/workout_service.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/routine.dart';

/// State for the routine create/edit screen.
class RoutineEditViewModel {
    RoutineEditViewModel(this._workout, this._routine);

    final WorkoutService _workout;

    final Routine _routine;

    final name = signal<String>('');
    final selectedDays = signal<Set<int>>({});
    final exerciseIds = signal<List<String>>([]);
    final saving = signal<bool>(false);
    final error = signal<String?>(null);

    void init(Routine routine) {
        name.value = routine.name;
        selectedDays.value = Set<int>.from(routine.dayOfWeek);
        exerciseIds.value = List<String>.from(routine.exerciseIds);
    }

    void toggleDay(int day) {
        final next = Set<int>.from(selectedDays.value);
        if (next.contains(day)) {
            next.remove(day);
        } else {
            next.add(day);
        }
        selectedDays.value = next;
    }

    void addExercise(String exerciseId) {
        if (exerciseIds.value.contains(exerciseId)) {
            return;
        }
        exerciseIds.value = [...exerciseIds.value, exerciseId];
    }

    void removeExercise(String exerciseId) {
        exerciseIds.value =
            exerciseIds.value.where((e) => e != exerciseId).toList();
    }

    /// Persists the routine after validation; returns true on success.
    Future<bool> save() async {
        final trimmed = name.value.trim();
        if (trimmed.isEmpty || trimmed.length > 50) {
            error.value =
                'Name must be between 1 and 50 characters.';
            return false;
        }
        if (exerciseIds.value.isEmpty) {
            error.value = 'Add at least one exercise.';
            return false;
        }
        saving.value = true;
        error.value = null;
        try {
            await _workout.saveRoutine(
                _routine.copyWith(
                    name: trimmed,
                    dayOfWeek: selectedDays.toList(),
                    exerciseIds: exerciseIds.value,
                ),
            );
            return true;
        } catch (e) {
            error.value = 'Could not save routine.';
            return false;
        } finally {
            saving.value = false;
        }
    }

    /// Creates a brand-new custom exercise directly from the routine editor.
    Future<String?> createCustomExercise(Exercise exercise) async {
        final id = _workout.newExerciseId();
        final withId = exercise.copyWith(
            id: id,
            isCustom: true,
            weightIncrement: MuscleGroups.incrementFor(exercise.muscleGroup),
        );
        await _workout.saveExercise(withId);
        return id;
    }
}
