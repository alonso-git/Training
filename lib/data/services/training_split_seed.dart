import '../../domain/entities/exercise.dart';
import '../../domain/entities/routine.dart';

/// Definitions for the shared training split.
///
/// Day 1: Heavy Push
/// Day 2: Pull & Posterior
/// Day 3: Volume & Isolation
/// Scheduled Monday, Wednesday, Friday for both trainees.
class TrainingSplitSeed {
    static const Map<String, List<int>> repRanges = {};

    static Future<void> seed(
        Future<bool> Function(String name) existsByName,
        Future<List<Exercise>> Function() allExercises,
        Future<void> Function(Exercise exercise) saveExercise,
        Future<void> Function(Routine routine) saveRoutine,
    ) async {
        final definitions = _exerciseDefinitions();
        final found = await allExercises();
        final byName = {
            for (final e in found)
                e.name.toLowerCase().trim(): e,
        };

        final ids = <String, String>{};
        var counter = 0;
        for (final d in definitions) {
            final key = d['name'] as String;
            final lower = key.toLowerCase().trim();
            final existing = byName[lower];
            if (existing != null) {
                ids[key] = existing.id;
                continue;
            }
            counter++;
            final id = 'split-ex-$counter-'
                '${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}';
            ids[key] = id;
            await saveExercise(
                Exercise(
                    id: id,
                    name: key,
                    muscleGroup: d['muscle'] as String,
                    sets: d['sets'] as int,
                    minReps: d['minReps'] as int,
                    maxReps: d['maxReps'] as int,
                    weightIncrement: d['increment'] as double,
                    isCustom: true,
                ),
            );
        }

        const mon = 1;
        const wed = 3;
        const fri = 5;
        final routines = [
            Routine(
                id: 'routine-gf-day1-heavy-push',
                name: 'GF Day 1: Heavy Push',
                dayOfWeek: [mon, wed, fri],
                exerciseIds: [
                    _need(ids, 'Hip Thrust'),
                    _need(ids, 'Leg Press'),
                    _need(ids, 'Abductor Machine'),
                    _need(ids, 'Lunges'),
                    _need(ids, 'Russian Twists'),
                ],
            ),
            Routine(
                id: 'routine-gf-day2-pull-posterior',
                name: 'GF Day 2: Pull & Posterior',
                dayOfWeek: [mon, wed, fri],
                exerciseIds: [
                    _need(ids, 'Romanian Deadlift (RDL)'),
                    _need(ids, 'Leg Curl'),
                    _need(ids, 'Cable Kickbacks'),
                    _need(ids, 'Abductor Machine'),
                    _need(ids, 'Leg Raises'),
                ],
            ),
            Routine(
                id: 'routine-gf-day3-volume-isolation',
                name: 'GF Day 3: Volume & Isolation',
                dayOfWeek: [mon, wed, fri],
                exerciseIds: [
                    _need(ids, 'Hip Thrust'),
                    _need(ids, 'Leg Press'),
                    _need(ids, 'Leg Extension'),
                    _need(ids, 'Cable Kickbacks'),
                    _need(ids, 'Plank Hold'),
                ],
            ),
            Routine(
                id: 'routine-me-day1-heavy-push',
                name: 'Day 1: Heavy Push',
                dayOfWeek: [mon, wed, fri],
                exerciseIds: [
                    _need(ids, 'Bench Press'),
                    _need(ids, 'Overhead Press'),
                    _need(ids, 'Bicep Curls'),
                    _need(ids, 'Rack Squats'),
                    _need(ids, 'Russian Twists'),
                ],
            ),
            Routine(
                id: 'routine-me-day2-pull-posterior',
                name: 'Day 2: Pull & Posterior',
                dayOfWeek: [mon, wed, fri],
                exerciseIds: [
                    _need(ids, 'Deadlift'),
                    _need(ids, 'Sandbag Clean & Press'),
                    _need(ids, 'Pull-ups'),
                    _need(ids, 'Lateral Raises'),
                    _need(ids, 'Leg Raises'),
                ],
            ),
            Routine(
                id: 'routine-me-day3-volume-isolation',
                name: 'Day 3: Volume & Isolation',
                dayOfWeek: [mon, wed, fri],
                exerciseIds: [
                    _need(ids, 'Bench Press'),
                    _need(ids, 'Bicep Curls'),
                    _need(ids, 'Pull-ups'),
                    _need(ids, 'Sandbag Clean & Press'),
                    _need(ids, 'Plank Hold'),
                ],
            ),
        ];
        for (final r in routines) {
            await saveRoutine(r);
        }
    }

    static String _need(Map<String, String> ids, String name) {
        final id = ids[name];
        if (id == null) {
            throw StateError('Missing seeded exercise: $name');
        }
        return id;
    }

    static List<Map<String, Object>> _exerciseDefinitions() {
        return [
            _ex('Hip Thrust', 'glutes', 3, 10, 15),
            _ex('Leg Press', 'quads', 3, 8, 12),
            _ex('Abductor Machine', 'glutes', 3, 12, 15),
            _ex('Lunges', 'quads', 3, 10, 10),
            _ex('Bench Press', 'chest', 3, 8, 12),
            _ex('Overhead Press', 'shoulders', 3, 8, 10),
            _ex('Bicep Curls', 'biceps', 3, 10, 15),
            _ex('Rack Squats', 'quads', 3, 8, 10),
            _ex('Romanian Deadlift (RDL)', 'hamstrings', 3, 8, 10),
            _ex('Leg Curl', 'hamstrings', 3, 10, 12),
            _ex('Cable Kickbacks', 'glutes', 3, 12, 15),
            _ex('Deadlift', 'back', 3, 6, 8),
            _ex('Sandbag Clean & Press', 'shoulders', 3, 8, 10),
            _ex('Pull-ups', 'back', 3, 5, 20),
            _ex('Lateral Raises', 'shoulders', 3, 12, 15),
            _ex('Leg Extension', 'quads', 3, 12, 15),
            _ex('Russian Twists', 'abs', 3, 15, 20),
            _ex('Leg Raises', 'abs', 3, 10, 15),
            _ex('Plank Hold', 'abs', 3, 45, 60),
        ];
    }

    static Map<String, Object> _ex(
        String name,
        String muscle,
        int sets,
        int minReps,
        int maxReps,
    ) {
        final increments = {
            'chest': 2.5,
            'shoulders': 2.5,
            'triceps': 2.5,
            'back': 2.5,
            'biceps': 1.25,
            'quads': 5.0,
            'hamstrings': 5.0,
            'glutes': 5.0,
            'calves': 5.0,
            'abs': 1.25,
        };
        return {
            'name': name,
            'muscle': muscle,
            'sets': sets,
            'minReps': minReps,
            'maxReps': maxReps,
            'increment': increments[muscle] ?? 1.25,
        };
    }
}
