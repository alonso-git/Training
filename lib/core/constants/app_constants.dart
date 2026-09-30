/// Muscle groups grouped by category, used for weight-increment logic.
enum MuscleCategory {
    upperBodyPush,
    upperBodyPull,
    legs,
    isolation,
}

class AppConstants {
    static const double upperBodyPushIncrement = 2.5;
    static const double upperBodyPullIncrement = 2.5;
    static const double legsIncrement = 5.0;
    static const double isolationIncrement = 1.25;

    static const int routineNameMinLength = 1;
    static const int routineNameMaxLength = 50;
    static const int exerciseNameMinLength = 1;
    static const int exerciseNameMaxLength = 100;
    static const int minSets = 1;
    static const int maxSets = 20;
    static const int minRepsLimit = 1;
    static const int maxRepsLimit = 50;
    static const int minMaxRepsLimit = 1;
    static const int maxMaxRepsLimit = 100;
    static const double minWeightKg = 0.0;
    static const double maxWeightKg = 1000.0;
    static const double weightStepKg = 0.25;
    static const double minWeightIncrementKg = 0.25;
    static const double maxWeightIncrementKg = 50.0;
}
