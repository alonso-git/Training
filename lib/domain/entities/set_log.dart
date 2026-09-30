class SetLog {
    const SetLog({required this.reps});

    final int reps;

    SetLog copyWith({int? reps}) {
        return SetLog(reps: reps ?? this.reps);
    }

    Map<String, dynamic> toJson() => {'reps': reps};

    static SetLog fromJson(Map<String, dynamic> json) {
        return SetLog(reps: (json['reps'] as num).toInt());
    }
}
