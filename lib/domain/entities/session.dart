import 'exercise_log.dart';

class Session {
    const Session({
        required this.id,
        required this.routineId,
        required this.routineName,
        required this.date,
        required this.duration,
        required this.exerciseLogs,
    });

    final String id;
    final String routineId;
    final String routineName;
    final DateTime date;
    final Duration duration;
    final List<ExerciseLog> exerciseLogs;

    double get volume {
        var total = 0.0;
        for (final log in exerciseLogs) {
            total += log.volume;
        }
        return total;
    }

    int get totalSets {
        var total = 0;
        for (final log in exerciseLogs) {
            total += log.sets.length;
        }
        return total;
    }

    Session copyWith({
        String? id,
        String? routineId,
        String? routineName,
        DateTime? date,
        Duration? duration,
        List<ExerciseLog>? exerciseLogs,
    }) {
        return Session(
            id: id ?? this.id,
            routineId: routineId ?? this.routineId,
            routineName: routineName ?? this.routineName,
            date: date ?? this.date,
            duration: duration ?? this.duration,
            exerciseLogs: exerciseLogs ?? this.exerciseLogs,
        );
    }

    Map<String, dynamic> toJson() => {
        'id': id,
        'routineId': routineId,
        'routineName': routineName,
        'date': date.toUtc().toIso8601String(),
        'durationSeconds': duration.inSeconds,
        'exerciseLogs': exerciseLogs.map((e) => e.toJson()).toList(),
    };

    static Session fromJson(Map<String, dynamic> json) {
        return Session(
            id: json['id'] as String,
            routineId: json['routineId'] as String,
            routineName: json['routineName'] as String? ?? '',
            date: DateTime.parse(json['date'] as String),
            duration: Duration(seconds: (json['durationSeconds'] as num).toInt()),
            exerciseLogs: (json['exerciseLogs'] as List)
                .map(
                    (e) => ExerciseLog.fromJson(
                        Map<String, dynamic>.from(e as Map),
                    ),
                )
                .toList(),
        );
    }
}
