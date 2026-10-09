import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

import '../../data/services/workout_service.dart';
import '../../domain/entities/routine.dart';
import '../state/profile_state.dart';
import '../view_models/home_view_model.dart';
import '../widgets/widget_card.dart';

class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final _vm = HomeViewModel(WorkoutService());

    @override
    void initState() {
        super.initState();
        _vm.load();
        ProfileState.load();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Workout Tracker'),
                actions: [
                    IconButton(
                        tooltip: 'History',
                        icon: const Icon(Icons.history),
                        onPressed: () => context.push('/history'),
                    ),
                    IconButton(
                        tooltip: 'Routines',
                        icon: const Icon(Icons.fitness_center),
                        onPressed: () => context.push('/routines'),
                    ),
                    IconButton(
                        tooltip: 'Settings',
                        icon: const Icon(Icons.settings),
                        onPressed: () => context.push('/settings'),
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
                // Profile-driven greeting widget.
                SignalBuilder(builder: (context) {
                    final theme = Theme.of(context);
                    final profile = ProfileState.profile.value;
                    return WidgetCard(
                        accentGradient: true,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Row(
                                    children: [
                                        CircleAvatar(
                                            radius: 20,
                                            backgroundColor: theme
                                                .colorScheme.primary,
                                            child: Text(
                                                profile.displayName
                                                    .characters
                                                    .first
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    color: theme
                                                        .colorScheme
                                                        .onPrimary,
                                                    fontWeight:
                                                        FontWeight.w700,
                                                ),
                                            ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                    Text(
                                                        'Hi, '
                                                        '${profile.displayName}!',
                                                        style: theme
                                                            .textTheme
                                                            .titleMedium,
                                                    ),
                                                    Text(
                                                        'Push day or rest day, '
                                                        'show up.',
                                                        style: theme.textTheme
                                                            .bodySmall
                                                            ?.copyWith(
                                                            color: theme
                                                                .colorScheme
                                                                .onSurfaceVariant,
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                        IconButton(
                                            tooltip: 'Edit profile',
                                            iconSize: 20,
                                            icon: const Icon(
                                                Icons.tune,
                                            ),
                                            onPressed: () =>
                                                context.push('/profile'),
                                        ),
                                    ],
                                ),
                                const SizedBox(height: 16),
                                // Training-week widget fed by the profile.
                                WeekStrip(
                                    trainingDays: profile.trainingDays,
                                    todayWeekday: DateTime.now().weekday,
                                    todayIsTrainingDay: null,
                                ),
                            ],
                        ),
                    );
                }),
                const SizedBox(height: 16),
                SignalBuilder(builder: (context2) {
                    final routines = _vm.todayRoutines.value;
                    if (_vm.loading.value) {
                        return const Center(
                            child: Padding(
                                padding: EdgeInsets.all(32),
                                child: CircularProgressIndicator(),
                            ),
                        );
                    }
                    if (routines.isEmpty) {
                        return WidgetCard(
                            child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                    children: [
                                        Icon(
                                            Icons.directions_run,
                                            size: 48,
                                            color: theme.colorScheme
                                                .primary,
                                        ),
                                        const SizedBox(height: 12),
                                        const Text('No routine today'),
                                        const SizedBox(height: 16),
                                        FilledButton.icon(
                                            onPressed: () => context
                                                .push('/routines?play=1'),
                                            icon: const Icon(
                                                Icons.play_arrow,
                                            ),
                                            label: const Text(
                                                'Pick routine to play',
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                        );
                    }
                    final routine = routines.first;
                    return _TodayRoutineCard(routine: routine);
                }),
                const SizedBox(height: 24),
                Text('Routines', style: theme.textTheme.titleLarge),
                const SizedBox(height: 8),
                SignalBuilder(builder: (context2) {
                    return FutureBuilder<List<Routine>>(
                        future: _vm.allRoutines(),
                        builder: (context, snap) {
                            final all = snap.data ?? const <Routine>[];
                            if (all.isEmpty) {
                                return Card(
                                    child: ListTile(
                                        leading:
                                            Icon(Icons.add_circle_outline),
                                        title: Text('Create your first routine'),
                                        onTap: () => context
                                            .push('/routines?create=1'),
                                    ),
                                );
                            }
                            return Column(
                                children: [
                                    for (final r in all)
                                        Card(
                                            child: ListTile(
                                                title: Text(r.name),
                                                subtitle: Text(
                                                    '${r.exerciseIds.length}'
                                                    ' exercises',
                                                ),
                                                 onTap: () =>
                                                     context.push(
                                                         '/routines/'
                                                         '${r.id}',
                                                     ),
                                                trailing: const Icon(
                                                    Icons.chevron_right,
                                                ),
                                            ),
                                        ),
                                ],
                            );
                        },
                    );
                }),
            ],
        );
    }
}

class _TodayRoutineCard extends StatelessWidget {
    const _TodayRoutineCard({required this.routine});

    final Routine routine;

    @override
    Widget build(BuildContext context) {
        final theme = Theme.of(context);
        return WidgetCard(
            accentGradient: true,
            padding: const EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                        'Today',
                        style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary,
                        ),
                    ),
                    const SizedBox(height: 4),
                    Text(routine.name, style: theme.textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    Row(
                        children: [
                            Icon(
                                Icons.local_fire_department,
                                size: 16,
                                color: theme.colorScheme.secondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                                '${routine.exerciseIds.length} exercises'
                                ' assigned for today',
                            ),
                        ],
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                        onPressed: () =>
                            context.push('/session/${routine.id}'),
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Start Workout'),
                    ),
                ],
            ),
        );
    }
}
