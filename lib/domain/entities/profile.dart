import 'package:flutter/material.dart';

/// User profile describing the global personality of the app.
class Profile {
    const Profile({
        required this.id,
        required this.name,
        required this.trainingDays,
        required this.themeModeIndex,
        required this.amoled,
    });

    static const String localId = 'local-profile';

    /// 0 = Sunday, 1 = Monday, ... 6 = Saturday (mirrors [Routine]).
    final String id;
    final String name;
    final List<int> trainingDays;

    /// 0 = system, 1 = light, 2 = dark. Mirrors [ThemeMode.index].
    final int themeModeIndex;
    final bool amoled;

    /// Profile used before the user configures anything.
    factory Profile.defaultProfile() {
        return const Profile(
            id: Profile.localId,
            name: '',
            trainingDays: [1, 3, 5],
            themeModeIndex: 2,
            amoled: true,
        );
    }

    ThemeMode get themeMode => ThemeMode.values[themeModeIndex.clamp(0, 2)];

    String get displayName {
        final trimmed = name.trim();
        return trimmed.isEmpty ? 'Athlete' : trimmed;
    }

    Profile copyWith({
        String? name,
        List<int>? trainingDays,
        int? themeModeIndex,
        bool? amoled,
    }) {
        return Profile(
            id: id,
            name: name ?? this.name,
            trainingDays: trainingDays ?? this.trainingDays,
            themeModeIndex: themeModeIndex ?? this.themeModeIndex,
            amoled: amoled ?? this.amoled,
        );
    }

    Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'trainingDays': trainingDays,
        'themeModeIndex': themeModeIndex,
        'amoled': amoled,
    };

    static Profile fromJson(Map<String, dynamic> json) {
        return Profile(
            id: json['id'] as String? ?? Profile.localId,
            name: json['name'] as String? ?? '',
            trainingDays: ((json['trainingDays'] as List?) ?? const [])
                .map((d) => (d as num).toInt())
                .toList(),
            themeModeIndex: (json['themeModeIndex'] as num?)?.toInt() ?? 0,
            amoled: json['amoled'] as bool? ?? false,
        );
    }
}

/// Selection bounds for training days in the profile screen.
abstract final class ProfileLimits {
    static const int minTrainingDays = 1;
    static const int maxTrainingDays = 7;

    /// Human labels for the weekday indices used in [Profile.trainingDays]
    /// (0 = Sunday ... 6 = Saturday).
    static const List<String> dayNames = [
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
    ];
}
