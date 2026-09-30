import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

import '../../data/services/workout_service.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/routine.dart';
import '../view_models/routine_edit_view_model.dart';

class RoutineEditScreen extends StatefulWidget {
    const RoutineEditScreen({
        required this.routineId,
        required this.isNew,
        super.key,
    });

    final String routineId;
    final bool isNew;

    @override
    State<RoutineEditScreen> createState() => _RoutineEditScreenState();
}

class _RoutineEditScreenState extends State<RoutineEditScreen> {
    late final RoutineEditViewModel _vm;
    late final Routine _routine;
    bool _ready = false;

    @override
    void initState() {
        super.initState();
        _load();
    }

    Future<void> _load() async {
        final workout = WorkoutService();
        final routine = await workout.findRoutine(widget.routineId) ??
            Routine(
                id: widget.routineId,
                name: '',
                dayOfWeek: const [],
                exerciseIds: const [],
            );
        if (!mounted) {
            return;
        }
        final vm = RoutineEditViewModel(workout, routine);
        vm.init(routine);
        setState(() {
            _vm = vm;
            _routine = routine;
            _ready = true;
        });
    }

    @override
    Widget build(BuildContext context) {
        if (!_ready) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
            );
        }
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.isNew ? 'New Routine' : 'Edit Routine'),
                actions: [
                    IconButton(
                        tooltip: 'Save routine',
                        icon: const Icon(Icons.save_outlined),
                        onPressed: _save,
                    ),
                ],
            ),
            body: _body(context),
        );
    }

    Widget _body(BuildContext context) {
        final theme = Theme.of(context);
        return ListView(
            padding: const EdgeInsets.all(16),
            children: [
                TextField(
                    key: const Key('routine-name-field'),
                    controller: TextEditingController(text: _vm.name.value),
                    maxLength: 50,
                    decoration: const InputDecoration(
                        labelText: 'Routine name',
                        hintText: 'e.g. Push day',
                    ),
                    onChanged: _vm.name.set,
                ),
                const SizedBox(height: 16),
                Text('Days of week', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                _dayChips(context),
                const SizedBox(height: 16),
                Text('Exercises', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                _exerciseList(context, theme),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add exercise'),
                    onPressed: _openExercisePicker,
                ),
                const SizedBox(height: 16),
                SignalBuilder(builder: (context2) {
                    final error = _vm.error.value;
                    if (error == null) {
                        return const SizedBox.shrink();
                    }
                    return Text(
                        error,
                        style: TextStyle(color: theme.colorScheme.error),
                    );
                }),
            ],
        );
    }

    Widget _dayChips(BuildContext context) {
        const dayLabels = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
        return SignalBuilder(
            builder: (context2) {
                return Wrap(
                    spacing: 8,
                    children: [
                        for (var day = 0; day < 7; day++)
                            FilterChip(
                                label: Text(dayLabels[day]),
                                selected: _vm.selectedDays.value.contains(day),
                                onSelected: (_) => _vm.toggleDay(day),
                            ),
                    ],
                );
            },
        );
    }

    Widget _exerciseList(BuildContext context, ThemeData theme) {
        return SignalBuilder(
            builder: (context2) {
                final ids = _vm.exerciseIds.value;
                if (ids.isEmpty) {
                    return Card(
                        child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                                'No exercises yet. Use the button below to '
                                'add exercises from the catalog or create '
                                'your own.',
                                style: theme.textTheme.bodySmall,
                            ),
                        ),
                    );
                }
                return FutureBuilder<List<Exercise>>(
                    future: WorkoutService().exercisesForRoutine(
                        _routine.copyWith(exerciseIds: ids),
                    ),
                    builder: (context, snapshot) {
                        final byId = <String, Exercise>{};
                        for (final e in snapshot.data ?? const <Exercise>[]) {
                            byId[e.id] = e;
                        }
                        return Column(
                            children: [
                                for (final id in ids)
                                    Card(
                                        child: ListTile(
                                            leading: Text(
                                                '${ids.indexOf(id) + 1}',
                                            ),
                                            title: Text(
                                                byId[id]?.name ?? 'Loading…',
                                            ),
                                            subtitle: Text(
                                                byId[id] == null
                                                    ? ''
                                                    : 'Sets: '
                                                        '${byId[id]!.sets} · '
                                                        'Reps '
                                                        '${byId[id]!.minReps}-'
                                                        '${byId[id]!.maxReps} · '
                                                        '+'
                                                        '${byId[id]!.weightIncrement} '
                                                        'kg/session',
                                            ),
                                            trailing: IconButton(
                                                icon: const Icon(
                                                    Icons.delete_outline,
                                                ),
                                                onPressed: () =>
                                                    _vm.removeExercise(id),
                                            ),
                                        ),
                                    ),
                            ],
                        );
                    },
                );
            },
        );
    }

    Future<void> _openExercisePicker() async {
        final picked = await context.push<List<String>>(
            '/exercises/picker',
        );
        if (picked != null) {
            for (final id in picked) {
                _vm.addExercise(id);
            }
            setState(() {});
        }
    }

    Future<void> _save() async {
        final ok = await _vm.save();
        if (ok && mounted) {
            await DataHub.refresh(AppServices.instance);
                if (mounted) {
                    context.go('/');
                }
        }
    }
}
