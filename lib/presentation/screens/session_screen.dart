import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

import '../../core/utils/format_utils.dart';
import '../../data/services/workout_service.dart';
import '../../domain/entities/exercise.dart';
import '../view_models/session_view_model.dart';
import '../widgets/weight_step_field.dart';

/// Exercise-by-exercise workout session flow.
class SessionScreen extends StatefulWidget {
    const SessionScreen({required this.routineId, super.key});

    final String routineId;

    @override
    State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
    late final SessionViewModel _vm = SessionViewModel(workout: WorkoutService());
    bool _started = false;

    @override
    void initState() {
        super.initState();
        _begin();
    }

    Future<void> _begin() async {
        if (_started) {
            return;
        }
        _started = true;
        final routine = await WorkoutService().findRoutine(widget.routineId);
        if (routine == null) {
            if (mounted) {
                context.go('/');
            }
            return;
        }
        await _vm.start(routine);
    }

    @override
    Widget build(BuildContext context) {
        return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
                if (!didPop) {
                    _confirmAbandon(context);
                }
            },
            child: Scaffold(
                appBar: AppBar(
                    title: const Text('Workout'),
                    actions: [
                        TextButton(
                            onPressed: () => _confirmAbandon(context),
                            child: const Text('Finish'),
                        ),
                    ],
                ),
                body: SignalBuilder(builder: (context2) {
                    if (_vm.loading.value) {
                        return const Center(
                            child: CircularProgressIndicator(),
                        );
                    }
                    final states = _vm.startStates;
                    if (states.isEmpty) {
                        return const Center(
                            child: Text('This routine has no exercises.'),
                        );
                    }
                    return _SessionBody(
                        vm: _vm,
                        states: states,
                        onExerciseCompleted: _onExerciseCompleted,
                        onAbandonRequested: () => _confirmAbandon(context),
                    );
                }),
            ),
        );
    }

    Future<void> _confirmAbandon(BuildContext context) async {
        final action = await showDialog<String>(
            context: context,
            builder: (context) {
                final hasData = !_vm.hasNoLoggedSets;
                return AlertDialog(
                    title: const Text('Finish workout?'),
                    content: Text(
                        hasData
                            ? 'Your logged sets will be saved.'
                            : 'You have not logged any reps yet. Nothing '
                                'will be saved.',
                    ),
                    actions: [
                        TextButton(
                            onPressed: () =>
                                Navigator.of(context).pop('continue'),
                            child: const Text('Keep going'),
                        ),
                        TextButton(
                            onPressed: () => Navigator.of(context).pop('quit'),
                            child: const Text('Discard'),
                        ),
                        FilledButton(
                            onPressed: () =>
                                Navigator.of(context).pop('save'),
                            child: const Text('Save session'),
                        ),
                    ],
                );
            },
        );
        if (!context.mounted) {
            return;
        }
        switch (action) {
            case 'save':
                await _finish(context);
            case 'quit':
                _vm.abandon();
                if (context.mounted) {
                    context.go('/');
                }
        }
    }

    Future<void> _finish(BuildContext context) async {
        final result = await _vm.finish();
        if (result == null) {
            if (context.mounted && _vm.error.value != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(_vm.error.value!),
                        backgroundColor:
                            Theme.of(context).colorScheme.error,
                    ),
                );
            }
            return;
        }
        if (context.mounted) {
            context.pushReplacement('/summary', extra: result);
        }
    }

    /// Advances to the next exercise, or saves + navigates to the summary
    /// when the last exercise has just been completed.
    Future<void> _onExerciseCompleted() async {
        if (mounted && _vm.currentIndex.value < _vm.startStates.length - 1) {
            await _vm.goToNextExercise();
            return;
        }
        await _finish(context);
    }
}

class _SessionBody extends StatelessWidget {
    const _SessionBody({
        required this.vm,
        required this.states,
        required this.onExerciseCompleted,
        required this.onAbandonRequested,
    });

    final SessionViewModel vm;
    final List<ExerciseStartState> states;
    final VoidCallback onExerciseCompleted;
    final VoidCallback onAbandonRequested;

    @override
    Widget build(BuildContext context) {
        return SignalBuilder(builder: (context2) {
            final state = vm.currentStartState;
            if (state == null) {
                return const Center(child: Text('Done.'));
            }
            final exercise = state.exercise;
            return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                    LinearProgressIndicator(
                        value:
                            (vm.currentIndex.value + 1) / states.length,
                    ),
                    const SizedBox(height: 8),
                    Text(
                        'Exercise ${vm.currentIndex.value + 1} of '
                        '${states.length}',
                        style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                        exercise.name,
                        key: const Key('session-exercise-name'),
                        style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                        'Target: ${exercise.sets} sets × '
                        '${exercise.minReps}-${exercise.maxReps} reps · '
                        'Muscle: ${exercise.muscleGroup}',
                    ),
                    const SizedBox(height: 16),
                    _suggestionBanner(context, state, exercise),
                    const SizedBox(height: 24),
                    _weightEditor(context),
                    const SizedBox(height: 24),
                    _setsProgress(context, exercise),
                    const SizedBox(height: 24),
                    if (vm.isCurrentExerciseComplete)
                        FilledButton.icon(
                            key: const Key('next-exercise-button'),
                            icon: const Icon(Icons.skip_next),
                            label: Text(
                                vm.currentIndex.value < states.length - 1
                                    ? 'Next exercise'
                                    : 'Last exercise — finish below',
                            ),
                            onPressed: onExerciseCompleted,
                        )
                    else
                        _repCounter(
                            context,
                            exercise,
                            onExerciseCompleted: onExerciseCompleted,
                        ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                        key: const Key('save-session-button'),
                        icon: const Icon(Icons.save),
                        label: const Text('Save session'),
                        onPressed: onExerciseCompleted,
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                        onPressed: onAbandonRequested,
                        child: const Text('Discard & quit'),
                    ),
                ],
            );
        });
    }

    Widget _suggestionBanner(
        BuildContext context,
        ExerciseStartState state,
        Exercise exercise,
    ) {
        if (!state.hasSuggestion) {
            if (state.lastWeight > 0) {
                return Card(
                    child: ListTile(
                        leading: const Icon(Icons.history),
                        title: Text(
                            'Last time: ${formatWeight(state.lastWeight)} kg',
                        ),
                    ),
                );
            }
            return const SizedBox.shrink();
        }
        return Card(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: ListTile(
                leading: Icon(
                    Icons.trending_up,
                    color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                    'Suggested weight: ${formatWeight(state.suggestedWeight)}'
                    ' kg',
                ),
                subtitle: const Text(
                    'You hit your target max reps this week. The suggested '
                    'weight is pre-filled below, you can change it.',
                ),
            ),
        );
    }

    Widget _weightEditor(BuildContext context) {
        return Card(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    children: [
                        Text(
                            'Weight (kg)',
                            style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(height: 8),
                        WeightStepField(
                            weight: vm.weight.value,
                            onChanged: vm.setWeight,
                            onIncrement: vm.incrementWeight,
                            onDecrement: vm.decrementWeight,
                        ),
                    ],
                ),
            ),
        );
    }

    Widget _setsProgress(BuildContext context, Exercise exercise) {
        final draft =
            vm.pendingLogs.value[vm.currentIndex.value];
        final setsLogged = draft.setLogs.length;
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(
                    'Sets: $setsLogged / ${exercise.sets}',
                    style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Wrap(
                    spacing: 8,
                    children: [
                        for (var i = 0; i < exercise.sets; i++)
                            Chip(
                                label: Text(
                                    i < setsLogged
                                        ? '${draft.setLogs[i].reps}'
                                        : '—',
                                ),
                                avatar: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: i < setsLogged
                                        ? Theme.of(
                                            context,
                                        ).colorScheme.primary
                                        : null,
                                    child: Text('${i + 1}'),
                                ),
                            ),
                    ],
                ),
                if (setsLogged > 0)
                    TextButton.icon(
                        icon: const Icon(Icons.undo),
                        label: const Text('Undo last set'),
                        onPressed: vm.undoLastSet,
                    ),
            ],
        );
    }

    Widget _repCounter(
        BuildContext context,
        Exercise exercise, {
        required VoidCallback onExerciseCompleted,
    }) {
        return Card(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    children: [
                        Text(
                            'Set ${vm.currentSetIndex.value + 1} '
                            'of ${exercise.sets}',
                        ),
                        RepStepper(
                            vm: vm,
                            initial: exercise.minReps,
                            onExerciseCompleted: onExerciseCompleted,
                        ),
                    ],
                ),
            ),
        );
    }
}

class RepStepper extends StatefulWidget {
    const RepStepper({
        required this.vm,
        required this.initial,
        required this.onExerciseCompleted,
        super.key,
    });

    final SessionViewModel vm;
    final int initial;
    final VoidCallback onExerciseCompleted;

    @override
    State<RepStepper> createState() => _RepStepperState();
}

class _RepStepperState extends State<RepStepper> {
    late int _reps = widget.initial;

    @override
    Widget build(BuildContext context) {
        return Column(
            children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                                if (_reps > 1) {
                                    setState(() => _reps--);
                                }
                            },
                        ),
                        Text(
                            '$_reps',
                            style: Theme.of(context).textTheme.displaySmall,
                        ),
                        IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                                if (_reps < 500) {
                                    setState(() => _reps++);
                                }
                            },
                        ),
                    ],
                ),
                FilledButton.icon(
                    key: const Key('log-set-button'),
                    icon: const Icon(Icons.check),
                    label: const Text('Log set'),
                    onPressed: () {
                        widget.vm.setDraftWeightForCurrent(
                            widget.vm.weight.value,
                        );
                        widget.vm.logCurrentSet(_reps);
                        if (widget.vm.isCurrentExerciseComplete) {
                            widget.onExerciseCompleted();
                        }
                    },
                ),
            ],
        );
    }
}
