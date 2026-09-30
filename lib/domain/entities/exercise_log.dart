import 'set_log.dart';

class ExerciseLog {
    const ExerciseLog({
        required this.exerciseId,
        required this.weight,
        required this.sets,
    });

    final String exerciseId;
    final double weight;
    final List<SetLog> sets;

    double get volume {
        var total = 0.0;
        for (final s in sets) {
            total += s.reps * weight;
        }
        return total;
    }

    int get maxReps {
        if (sets.isEmpty) {
            return 0;
        }
        var max = 0;
        for (final s in sets) {
            if (s.reps > max) {
                max = s.reps;
            }
        }
        return max;
    }

    ExerciseLog copyWith({
        String? exerciseId,
        double? weight,
        List<SetLog>? sets,
    }) {
        return ExerciseLog(
            exerciseId: exerciseId ?? this.exerciseId,
            weight: weight ?? this.weight,
            sets: sets ?? this.sets,
        );
    }

    Map<String, dynamic> toJson() => {
        'exerciseId': exerciseId,
        'weight': weight,
        'sets': sets.map((s) => s.toJson()).toList(),
    };

    static ExerciseLog fromJson(Map<String, dynamic> json) {
        return ExerciseLog(
            exerciseId: json['exerciseId'] as String,
            weight: (json['weight'] as num).toDouble(),
            sets: (json['sets'] as List)
                .map((s) => SetLog.fromJson(Map<String, dynamic>.from(s as Map)))
                .toList(),
        );
    }
}
