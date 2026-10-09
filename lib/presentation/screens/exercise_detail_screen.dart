import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

import '../../core/constants/muscle_groups.dart';
import '../../core/utils/date_utils.dart' as d;
import '../../core/utils/format_utils.dart';
import '../view_models/history_view_model.dart';

class ExerciseDetailScreen extends StatefulWidget {
    const ExerciseDetailScreen({
        required this.exerciseId,
        required this.exerciseName,
        super.key,
    });

    final String exerciseId;
    final String exerciseName;

    @override
    State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
    final _vm = ExerciseDetailViewModel();

    @override
    void initState() {
        super.initState();
        _vm.load(widget.exerciseId);
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: Text(widget.exerciseName)),
            body: SignalBuilder(
                builder: (context2) {
                    final exercise = _vm.exercise.value;
                    if (_vm.loading.value) {
                        return const Center(child: CircularProgressIndicator());
                    }
                    if (exercise == null) {
                        return const Center(child: Text('Exercise not found.'));
                    }
                    final sessions = _vm.sessions.value;
                    return ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                            Card(
                                child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                                exercise.name,
                                                style: Theme.of(context2)
                                                    .textTheme
                                                    .headlineSmall,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                                '${MuscleGroups.labelOf(exercise.muscleGroup)}'
                                                ' · Sets: ${exercise.sets} · '
                                                'Reps ${exercise.minReps}-'
                                                '${exercise.maxReps} · '
                                                '+${formatWeight(exercise.weightIncrement)}'
                                                ' kg/session'
                                                '${exercise.hasRestTimer
                                                    ? ' · Rest: '
                                                        '${formatRestDuration(exercise.restSeconds)}'
                                                    : ' · No rest timer'}',
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                                'Sessions (${sessions.length})',
                                style:
                                    Theme.of(context2).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            if (sessions.isEmpty)
                                const Text('No sessions recorded yet.'),
                            for (final session in sessions)
                                Card(
                                    child: ListTile(
                                        title: Text(
                                            d.AppDateUtils.formatDate(
                                                session.date,
                                            ),
                                        ),
                                        subtitle: Text(
                                            '${session.routineName} · '
                                            '${formatWeight(_weight(session, widget.exerciseId))}'
                                            ' kg · max '
                                            '${_maxReps(session, widget.exerciseId)}'
                                            ' reps',
                                        ),
                                        trailing: Icon(
                                            Icons.chevron_right,
                                        ),
                                        onTap: () => context.push(
                                            '/history/detail',
                                            extra: session,
                                        ),
                                    ),
                                ),
                        ],
                    );
                },
            ),
        );
    }

    double _weight(dynamic session, String exerciseId) {
        for (final log in session.exerciseLogs) {
            if (log.exerciseId == exerciseId) {
                return log.weight;
            }
        }
        return 0.0;
    }

    int _maxReps(dynamic session, String exerciseId) {
        var max = 0;
        for (final log in session.exerciseLogs) {
            if (log.exerciseId == exerciseId) {
                max = log.maxReps;
            }
        }
        return max;
    }
}
