import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

import '../../data/services/workout_service.dart';
import '../view_models/routines_view_model.dart';

class RoutinesScreen extends StatefulWidget {
    const RoutinesScreen({super.key});

    @override
    State<RoutinesScreen> createState() => _RoutinesScreenState();
}

class _RoutinesScreenState extends State<RoutinesScreen> {
    final _vm = RoutinesViewModel(WorkoutService());
    bool _createRequested = false;

    @override
    void initState() {
        super.initState();
        _vm.load();
    }

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        if (!_createRequested &&
            GoRouterState.of(context).uri.queryParameters['create'] == '1') {
            _createRequested = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) {
                    return;
                }
                final draft = _vm.newDraft();
                context.push('/routines/${draft.id}?new=1');
            });
        }
    }

    bool get _playMode {
        return GoRouterState.of(context).uri.queryParameters['play'] == '1';
    }

    @override
    Widget build(BuildContext context) {
        final playMode = _playMode;
        return Scaffold(
            appBar: AppBar(
                title: Text(playMode ? 'Pick routine to play' : 'Routines'),
            ),
            floatingActionButton: playMode
                ? null
                : FloatingActionButton.extended(
                    onPressed: () {
                        final draft = _vm.newDraft();
                        context.push('/routines/${draft.id}?new=1');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('New Routine'),
                ),
            body: SignalBuilder(builder: (context2) {
                if (_vm.loading.value) {
                    return const Center(child: CircularProgressIndicator());
                }
                final routines = _vm.routines.value;
                if (routines.isEmpty) {
                    return const Center(
                        child: Text('No routines yet. Create one to start.'),
                    );
                }
                return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: routines.length,
                    itemBuilder: (context, index) {
                        final routine = routines[index];
                        return Card(
                            child: ListTile(
                                title: Text(routine.name),
                                subtitle: Text(
                                    '${routine.exerciseIds.length} exercises · '
                                    '${routine.dayOfWeek.length} days',
                                ),
                                leading: playMode
                                    ? const Icon(Icons.play_circle_outline)
                                    : null,
                                trailing: playMode
                                    ? const Icon(Icons.chevron_right)
                                    : IconButton(
                                        icon: const Icon(
                                            Icons.delete_outline,
                                        ),
                                        onPressed: () async {
                                            final confirmed = await
                                                _confirmDelete(
                                                context,
                                                routine.name,
                                            );
                                            if (confirmed) {
                                                await _vm.deleteRoutine(
                                                    routine.id,
                                                );
                                            }
                                        },
                                    ),
                                onTap: playMode
                                    ? () =>
                                        context.push(
                                            '/session/${routine.id}',
                                        )
                                    : () =>
                                        context.push(
                                            '/routines/${routine.id}',
                                        ),
                            ),
                        );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                );
            }),
        );
    }

    Future<bool> _confirmDelete(BuildContext context, String name) async {
        final result = await showDialog<bool>(
            context: context,
            builder: (context) {
                return AlertDialog(
                    title: const Text('Delete routine?'),
                    content: Text(
                        '"$name" will be permanently deleted. Sessions are '
                        'kept in history.',
                    ),
                    actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                        ),
                        FilledButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Delete'),
                        ),
                    ],
                );
            },
        );
        return result ?? false;
    }
}
