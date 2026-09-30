class Exercise {
    const Exercise({
        required this.id,
        required this.name,
        required this.muscleGroup,
        required this.sets,
        required this.minReps,
        required this.maxReps,
        required this.weightIncrement,
        required this.isCustom,
    });

    final String id;
    final String name;
    final String muscleGroup;
    final int sets;
    final int minReps;
    final int maxReps;
    final double weightIncrement;
    final bool isCustom;

    Exercise copyWith({
        String? id,
        String? name,
        String? muscleGroup,
        int? sets,
        int? minReps,
        int? maxReps,
        double? weightIncrement,
        bool? isCustom,
    }) {
        return Exercise(
            id: id ?? this.id,
            name: name ?? this.name,
            muscleGroup: muscleGroup ?? this.muscleGroup,
            sets: sets ?? this.sets,
            minReps: minReps ?? this.minReps,
            maxReps: maxReps ?? this.maxReps,
            weightIncrement: weightIncrement ?? this.weightIncrement,
            isCustom: isCustom ?? this.isCustom,
        );
    }

    Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'muscleGroup': muscleGroup,
        'sets': sets,
        'minReps': minReps,
        'maxReps': maxReps,
        'weightIncrement': weightIncrement,
        'isCustom': isCustom,
    };

    static Exercise fromJson(Map<String, dynamic> json) {
        return Exercise(
            id: json['id'] as String,
            name: json['name'] as String,
            muscleGroup: json['muscleGroup'] as String,
            sets: (json['sets'] as num).toInt(),
            minReps: (json['minReps'] as num).toInt(),
            maxReps: (json['maxReps'] as num).toInt(),
            weightIncrement: (json['weightIncrement'] as num).toDouble(),
            isCustom: json['isCustom'] as bool? ?? false,
        );
    }
}
