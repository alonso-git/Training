import 'app_constants.dart';

/// Maps a muscle group id to its category for increment calculation.
class MuscleGroups {
    static const Map<String, MuscleCategory> categories = {
        'chest': MuscleCategory.upperBodyPush,
        'shoulders': MuscleCategory.upperBodyPush,
        'triceps': MuscleCategory.upperBodyPush,
        'back': MuscleCategory.upperBodyPull,
        'biceps': MuscleCategory.upperBodyPull,
        'quads': MuscleCategory.legs,
        'hamstrings': MuscleCategory.legs,
        'glutes': MuscleCategory.legs,
        'calves': MuscleCategory.legs,
        'abs': MuscleCategory.isolation,
        'forearms': MuscleCategory.isolation,
        'neck': MuscleCategory.isolation,
    };

    static const Map<String, String> labels = {
        'chest': 'Chest',
        'shoulders': 'Shoulders',
        'triceps': 'Triceps',
        'back': 'Back',
        'biceps': 'Biceps',
        'quads': 'Quads',
        'hamstrings': 'Hamstrings',
        'glutes': 'Glutes',
        'calves': 'Calves',
        'abs': 'Abs',
        'forearms': 'Forearms',
        'neck': 'Neck',
    };

    static const List<String> all = [
        'chest',
        'shoulders',
        'triceps',
        'back',
        'biceps',
        'quads',
        'hamstrings',
        'glutes',
        'calves',
        'abs',
        'forearms',
        'neck',
    ];

    static MuscleCategory categoryOf(String muscleGroup) {
        return categories[muscleGroup] ?? MuscleCategory.isolation;
    }

    static double incrementFor(String muscleGroup) {
        switch (categoryOf(muscleGroup)) {
            case MuscleCategory.upperBodyPush:
                return AppConstants.upperBodyPushIncrement;
            case MuscleCategory.upperBodyPull:
                return AppConstants.upperBodyPullIncrement;
            case MuscleCategory.legs:
                return AppConstants.legsIncrement;
            case MuscleCategory.isolation:
                return AppConstants.isolationIncrement;
        }
    }

    static String labelOf(String muscleGroup) {
        return labels[muscleGroup] ?? muscleGroup;
    }
}
