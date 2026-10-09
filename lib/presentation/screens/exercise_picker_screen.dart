import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

import '../../core/constants/muscle_groups.dart';
import '../../data/services/workout_service.dart';
import '../../domain/entities/exercise.dart';
import '../view_models/exercise_config_view_model.dart';
import '../view_models/exercise_picker_view_model.dart';
import '../widgets/number_field.dart';

/// Choose exercises from the catalog (or create custom ones) and return the
/// selected ids to the caller.
class ExercisePickerScreen extends StatefulWidget {
    const ExercisePickerScreen({super.key});

    @override
    State<ExercisePickerScreen> createState() => _ExercisePickerScreenState();
}

class _ExercisePickerScreenState extends State<ExercisePickerScreen> {
    final _vm = ExercisePickerViewModel(WorkoutService());
    final _selected = <String>{};

    bool get _multiSelect {
        final extra = GoRouterState.of(context).uri.queryParameters['multi'];
        return extra == '1';
    }

    @override
    void initState() {
        super.initState();
        _vm.load();
    }

    @override
    Widget build(BuildContext context) {
        final multi = _multiSelect;
        return Scaffold(
            appBar: AppBar(title: const Text('Choose exercises')),
            floatingActionButton: multi
                ? FloatingActionButton.extended(
                    onPressed: () => context.pop(_selected.toList()),
                    icon: const Icon(Icons.check),
                    label: Text('Add ${_selected.length}'),
                )
                : null,
            body: Column(
                children: [
                    Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                            children: [
                                Expanded(
                                    child: TextField(
                                        decoration: const InputDecoration(
                                            prefixIcon: Icon(Icons.search),
                                            labelText: 'Search',
                                        ),
                                        onChanged: _vm.setQuery,
                                    ),
                                ),
                                const SizedBox(width: 8),
                                SignalBuilder(builder: (context2) {
                                    return DropdownButton<String?>(
                                        value:
                                            _vm.selectedMuscleGroup.value,
                                        hint: const Text('Muscle'),
                                        items: [
                                            const DropdownMenuItem<
                                                String?>(
                                                value: null,
                                                child: Text('All'),
                                            ),
                                            for (final m
                                                in MuscleGroups.all)
                                                DropdownMenuItem<String?>(
                                                    value: m,
                                                    child: Text(
                                                        MuscleGroups
                                                            .labelOf(m),
                                                    ),
                                                ),
                                        ],
                                        onChanged: _vm.setMuscleGroupFilter,
                                    );
                                }),
                            ],
                        ),
                    ),
                    Expanded(
                        child: SignalBuilder(builder: (context2) {
                            final exercises = _vm.filtered();
                            return ListView.builder(
                                itemCount: exercises.length,
                                itemBuilder: (context, index) {
                                    final exercise = exercises[index];
                                    return _tile(context, exercise, multi);
                                },
                            );
                        }),
                    ),
                    if (!multi)
                        Padding(
                            padding: const EdgeInsets.all(12),
                            child: OutlinedButton.icon(
                                icon: const Icon(Icons.add_circle_outline),
                                label: const Text('Create custom exercise'),
                                onPressed: _openCustomCreator,
                            ),
                        ),
                ],
            ),
        );
    }

    Widget _tile(BuildContext context, Exercise exercise, bool multi) {
        final selected = _selected.contains(exercise.id);
        return Card(
            child: ListTile(
                title: Text(exercise.name),
                subtitle: Text(
                    '${MuscleGroups.labelOf(exercise.muscleGroup)} · '
                    'Sets: ${exercise.sets} · '
                    'Reps ${exercise.minReps}-${exercise.maxReps}',
                ),
                trailing: exercise.isCustom
                    ? const Icon(Icons.build_outlined)
                    : null,
                selected: selected,
                onTap: () {
                    if (multi) {
                        setState(() {
                            selected
                                ? _selected.remove(exercise.id)
                                : _selected.add(exercise.id);
                        });
                        return;
                    }
                    context.pop(<String>[exercise.id]);
                },
            ),
        );
    }

    Future<void> _openCustomCreator() async {
        final created = await showExerciseConfigDialog(context);
        if (!mounted || created == null) {
            return;
        }
        final id = await _vm.createCustom(created);
        if (mounted && id.isNotEmpty) {
            context.pop(<String>[id]);
        }
    }
}

/// Dialog form for creating (or editing) a custom exercise; returns the built
/// [Exercise] or null when cancelled.
Future<Exercise?> showExerciseConfigDialog(
    BuildContext context, {
    Exercise? existing,
}) async {
    final vm = ExerciseConfigViewModel();
    if (existing != null) {
        vm.loadFrom(existing);
    }
    final body = _ExerciseConfigDialog(vm: vm, existing: existing);
    return showDialog<Exercise>(context: context, builder: (_) => body);
}

class _ExerciseConfigDialog extends StatefulWidget {
    const _ExerciseConfigDialog({required this.vm, this.existing});

    final ExerciseConfigViewModel vm;
    final Exercise? existing;

    @override
    State<_ExerciseConfigDialog> createState() =>
        _ExerciseConfigDialogState();
}

class _ExerciseConfigDialogState extends State<_ExerciseConfigDialog> {
    late final TextEditingController _name =
        TextEditingController(text: widget.vm.name.value);

    @override
    void dispose() {
        _name.dispose();
        super.dispose();
    }

    void _setMuscleGroup(String? value) {
        setState(() {
            widget.vm.muscleGroup.value = value ?? 'chest';
            if (widget.existing == null) {
                widget.vm.weightIncrement.value =
                    MuscleGroups.incrementFor(value!);
            }
        });
    }

    void _setMinReps(double value) {
        setState(() {
            widget.vm.minReps.value = value.toInt();
            if (value > widget.vm.maxReps.value) {
                widget.vm.maxReps.value = value.toInt();
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        final vm = widget.vm;
        return AlertDialog(
            title: Text(
                widget.existing == null
                    ? 'Custom exercise'
                    : 'Edit exercise',
            ),
            titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
            contentPadding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
            insetPadding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 48,
            ),
            content: SizedBox(
                width: 440,
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            TextField(
                                controller: _name,
                                maxLength: 100,
                                decoration: const InputDecoration(
                                    labelText: 'Name',
                                ),
                                onChanged: vm.name.set,
                            ),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                                initialValue: vm.muscleGroup.value,
                                decoration: const InputDecoration(
                                    labelText: 'Muscle group',
                                ),
                                items: [
                                    for (final m in MuscleGroups.all)
                                        DropdownMenuItem(
                                            value: m,
                                            child: Text(
                                                MuscleGroups.labelOf(m),
                                            ),
                                        ),
                                ],
                                onChanged: _setMuscleGroup,
                            ),
                            const SizedBox(height: 20),
                            _numberField(
                                'Sets',
                                vm.sets.value,
                                1,
                                20,
                                (v) => setState(
                                    () => vm.sets.value = v.toInt(),
                                ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                                children: [
                                    Expanded(
                                        child: _numberField(
                                            'Min reps',
                                            vm.minReps.value,
                                            1,
                                            50,
                                            _setMinReps,
                                        ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                        child: _numberField(
                                            'Max reps',
                                            vm.maxReps.value,
                                            1,
                                            100,
                                            (v) => setState(
                                                () => vm.maxReps.value =
                                                    v.toInt(),
                                            ),
                                        ),
                                    ),
                                ],
                            ),
                            const SizedBox(height: 20),
                            _numberField(
                                'Weight increment (kg)',
                                vm.weightIncrement.value,
                                0.25,
                                50,
                                (v) => setState(
                                    () => vm.weightIncrement.value = v,
                                ),
                            ),
                            const SizedBox(height: 20),
                            _numberField(
                                'Rest between sets (s)',
                                vm.restSeconds.value,
                                minRestSeconds,
                                maxRestSeconds,
                                (v) => setState(
                                    () => vm.restSeconds.value = v.toInt(),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            actionsPadding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
            actionsOverflowButtonSpacing: 8,
            actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                ),
                FilledButton(
                    onPressed: () {
                        final error = vm.validate();
                        if (error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error)),
                            );
                            return;
                        }
                        Navigator.of(context).pop(
                            vm.build(WorkoutService()),
                        );
                    },
                    child: const Text('Save'),
                ),
            ],
        );
    }
}

Widget _numberField(
    String label,
    num value,
    num min,
    num max,
    ValueChanged<double> onChanged,
) {
    return NumberField(
        value: value,
        min: min,
        max: max,
        onChanged: onChanged,
        decoration: InputDecoration(
            labelText: label,
            helperText: 'Min $min · Max $max',
        ),
    );
}
