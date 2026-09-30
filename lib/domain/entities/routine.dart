class Routine {
    const Routine({
        required this.id,
        required this.name,
        required this.dayOfWeek,
        required this.exerciseIds,
    });

    /// 0 = Sunday, 1 = Monday, ... 6 = Saturday.
    final String id;
    final String name;
    final List<int> dayOfWeek;
    final List<String> exerciseIds;

    bool isOnWeekday(DateTime dt) {
        return dayOfWeek.contains(dt.weekday % 7);
    }

    Routine copyWith({
        String? id,
        String? name,
        List<int>? dayOfWeek,
        List<String>? exerciseIds,
    }) {
        return Routine(
            id: id ?? this.id,
            name: name ?? this.name,
            dayOfWeek: dayOfWeek ?? this.dayOfWeek,
            exerciseIds: exerciseIds ?? this.exerciseIds,
        );
    }

    Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'dayOfWeek': dayOfWeek,
        'exerciseIds': exerciseIds,
    };

    static Routine fromJson(Map<String, dynamic> json) {
        return Routine(
            id: json['id'] as String,
            name: json['name'] as String,
            dayOfWeek: (json['dayOfWeek'] as List)
                .map((d) => (d as num).toInt())
                .toList(),
            exerciseIds: (json['exerciseIds'] as List)
                .map((e) => e as String)
                .toList(),
        );
    }
}
