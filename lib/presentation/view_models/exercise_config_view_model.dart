import 'package:signals/signals.dart';

import '../../data/services/workout_service.dart';
import '../../domain/entities/exercise.dart';

/// Draft state for configuring a new custom exercise.
class ExerciseConfigViewModel {
    ExerciseConfigViewModel();

    final name = signal<String>('');
    final muscleGroup = signal<String>('chest');
    final sets = signal<int>(3);
    final minReps = signal<int>(8);
    final maxReps = signal<int>(12);
    final weightIncrement = signal<double>(2.5);
    final restSeconds = signal<int>(defaultRestSeconds);
    final existingId = signal<String?>(null);

    void loadFrom(Exercise exercise) {
        existingId.value = exercise.id.isEmpty ? null : exercise.id;
        name.value = exercise.name;
        muscleGroup.value = exercise.muscleGroup;
        sets.value = exercise.sets;
        minReps.value = exercise.minReps;
        maxReps.value = exercise.maxReps;
        weightIncrement.value = exercise.weightIncrement;
        restSeconds.value = exercise.restSeconds;
    }

    void setMaxRepsFromMin(int value) {
        if (value > maxReps.value) {
            maxReps.value = value;
        }
    }

    void setMinRepsFromMax(int value) {
        if (value >= 1 && value <= minReps.value) {
            // nothing to shrink below min
        } else {
            minReps.value = value.clamp(1, maxReps.value);
        }
    }

    String? validate() {
        if (name.value.trim().isEmpty || name.value.trim().length > 100) {
            return 'Name must be 1-100 characters.';
        }
        if (sets.value < 1 || sets.value > 20) {
            return 'Sets must be between 1 and 20.';
        }
        if (minReps.value < 1 || minReps.value > 50) {
            return 'Min reps must be between 1 and 50.';
        }
        if (maxReps.value < 1 || maxReps.value > 100) {
            return 'Max reps must be between 1 and 100.';
        }
        if (maxReps.value < minReps.value) {
            return 'Max reps must be greater than or equal to min reps.';
        }
        if (weightIncrement.value < 0.25 || weightIncrement.value > 50) {
            return 'Weight increment must be 0.25-50 kg.';
        }
        if (restSeconds.value < minRestSeconds ||
            restSeconds.value > maxRestSeconds) {
            return 'Rest must be between $minRestSeconds and '
                '$maxRestSeconds seconds.';
        }
        return null;
    }

    Exercise build(WorkoutService workout, {bool isCustom = true}) {
        return Exercise(
            id: existingId.value ?? workout.newExerciseId(),
            name: name.value.trim(),
            muscleGroup: muscleGroup.value,
            sets: sets.value,
            minReps: minReps.value,
            maxReps: maxReps.value,
            weightIncrement: weightIncrement.value,
            isCustom: isCustom,
            restSeconds: restSeconds.value,
        );
    }
}
