import 'package:signals/signals.dart';

import '../../data/services/workout_service.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/session.dart';
import '../../domain/entities/exercise_log.dart';

/// Chart aggregates for the progress screen.
class WeightPoint {
    const WeightPoint({required this.date, required this.weight});
    final DateTime date;
    final double weight;
}

class VolumePoint {
    const VolumePoint({required this.label, required this.volume});
    final String label;
    final double volume;
}

class FrequencyPoint {
    const FrequencyPoint({required this.label, required this.count});
    final String label;
    final int count;
}

class ProgressViewModel {
    ProgressViewModel({WorkoutService? workout}) :
        _workout = workout ?? WorkoutService();

    final WorkoutService _workout;

    final exercises = signal<List<Exercise>>(const []);
    final selectedExerciseId = signal<String?>(null);
    final weightPoints = signal<List<WeightPoint>>(const []);
    final volumePoints = signal<List<VolumePoint>>(const []);
    final frequencyPoints = signal<List<FrequencyPoint>>(const []);
    final loading = signal<bool>(true);

    Future<void> load() async {
        loading.value = true;
        exercises.value = await _workout.listExercises();
        final sessions = await _workout.sessionsList();
        volumePoints.value = _volumeTrend(sessions);
        frequencyPoints.value = _frequency(sessions);
        if (selectedExerciseId.value != null) {
            await _loadWeightFor(selectedExerciseId.value!);
        }
        loading.value = false;
    }

    Future<void> selectExercise(String exerciseId) async {
        selectedExerciseId.value = exerciseId;
        await _loadWeightFor(exerciseId);
    }

    Future<void> _loadWeightFor(String exerciseId) async {
        final sessions = await _workout.sessionsForExercise(exerciseId);
        final chrono = sessions.reversed.toList();
        final points = <WeightPoint>[];
        for (final session in chrono) {
            ExerciseLog? log;
            for (final l in session.exerciseLogs) {
                if (l.exerciseId == exerciseId) {
                    log = l;
                }
            }
            if (log != null) {
                points.add(WeightPoint(date: session.date, weight: log.weight));
            }
        }
        weightPoints.value = points;
    }

    List<VolumePoint> _volumeTrend(List<Session> sessionsDesc) {
        final chrono = sessionsDesc.reversed.toList();
        return [
            for (final s in chrono)
                VolumePoint(
                    label: '${s.date.month}/${s.date.day}',
                    volume: s.volume,
                ),
        ];
    }

    List<FrequencyPoint> _frequency(List<Session> sessionsDesc) {
        final counts = <String, int>{};
        final order = <String>[];
        final chrono = sessionsDesc.reversed.toList();
        for (final s in chrono) {
            final key = 'W${_weekOfYear(s.date)}';
            counts[key] = (counts[key] ?? 0) + 1;
            if (!order.contains(key)) {
                order.add(key);
            }
        }
        return [
            for (final key in order) FrequencyPoint(label: key, count: counts[key] ?? 0),
        ];
    }

    static int _weekOfYear(DateTime dt) {
        final first = DateTime(dt.year, 1, 1);
        final days = dt.difference(first).inDays;
        return ((days + first.weekday - 1) / 7).ceil() + 1;
    }
}
