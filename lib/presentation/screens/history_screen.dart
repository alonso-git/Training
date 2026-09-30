import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

import '../../core/utils/date_utils.dart';
import '../../core/utils/format_utils.dart';
import '../../domain/entities/session.dart';
import '../view_models/history_view_model.dart';

/// Lists every recorded session; tap for the per-exercise detail view.
class HistoryScreen extends StatefulWidget {
    const HistoryScreen({super.key});

    @override
    State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
    final _vm = HistoryViewModel();

    @override
    void initState() {
        super.initState();
        _vm.load();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('History')),
            body: SignalBuilder(builder: (context2) {
                if (_vm.loading.value) {
                    return const Center(child: CircularProgressIndicator());
                }
                final sessions = _vm.sessions.value;
                if (sessions.isEmpty) {
                    return const Center(
                        child: Text('No sessions yet. Complete a workout!'),
                    );
                }
                return RefreshIndicator(
                    onRefresh: _vm.load,
                    child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: sessions.length,
                        itemBuilder: (context, index) {
                            final session = sessions[index];
                            return Dismissible(
                                key: ValueKey(session.id),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 24),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .errorContainer,
                                        borderRadius:
                                            BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                        Icons.delete_outline,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onErrorContainer,
                                    ),
                                ),
                                confirmDismiss: (_) =>
                                    _confirmDelete(context, session),
                                onDismissed: (_) {
                                    _vm.deleteSession(session.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Deleted "${session.routineName}"'
                                                ' session',
                                            ),
                                        ),
                                    );
                                },
                                child: Card(
                                    child: ListTile(
                                        title: Text(session.routineName),
                                        subtitle: Text(
                                            AppDateUtils.formatDateTime(
                                                session.date,
                                            ),
                                        ),
                                        trailing: Text(
                                            '${session.totalSets} sets · '
                                            '${session.volume.toStringAsFixed(0)} kg',
                                        ),
                                        onTap: () => context.push(
                                            '/history/detail',
                                            extra: session,
                                        ),
                                    ),
                                ),
                            );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                    ),
                );
            }),
        );
    }

    Future<bool> _confirmDelete(
        BuildContext context,
        Session session,
    ) async {
        final action = await showDialog<String>(
            context: context,
            builder: (dialogContext) {
                return AlertDialog(
                    title: const Text('Delete session?'),
                    content: Text(
                        '"${session.routineName}" from '
                        '${AppDateUtils.formatDateTime(session.date)} '
                        'will be removed permanently.',
                    ),
                    actions: [
                        TextButton(
                            onPressed: () =>
                                Navigator.of(dialogContext).pop('cancel'),
                            child: const Text('Cancel'),
                        ),
                        FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
                            ),
                            onPressed: () =>
                                Navigator.of(dialogContext).pop('delete'),
                            child: const Text('Delete'),
                        ),
                    ],
                );
            },
        );
        return action == 'delete';
    }
}

/// Per-exercise breakdown of one saved session, with names resolved.
class SessionDetailScreen extends StatefulWidget {
    const SessionDetailScreen({required this.session, super.key});

    final Session session;

    @override
    State<SessionDetailScreen> createState() => _SessionDetailScreenState();
}

class _SessionDetailScreenState extends State<SessionDetailScreen> {
    final _vm = HistoryViewModel();

    @override
    void initState() {
        super.initState();
        _vm.load();
    }

    @override
    Widget build(BuildContext context) {
        final session = widget.session;
        return Scaffold(
            appBar: AppBar(title: Text(session.routineName)),
            body: SignalBuilder(builder: (context) {
                if (_vm.loading.value) {
                    return const Center(child: CircularProgressIndicator());
                }
                return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                        Card(
                            child: ListTile(
                                title: const Text('Session'),
                                subtitle: Text(
                                    '${AppDateUtils.formatDateTime(session.date)}'
                                    ' · ${AppDateUtils.formatDuration(session.duration)}'
                                    ' · ${session.totalSets} sets · '
                                    '${session.volume.toStringAsFixed(0)} kg',
                                ),
                            ),
                        ),
                        const SizedBox(height: 8),
                        for (final log in session.exerciseLogs)
                            Card(
                                child: ListTile(
                                    title: Text(
                                        _vm.exerciseName(log.exerciseId),
                                    ),
                                    subtitle: Text(
                                        '${formatWeight(log.weight)} kg · '
                                        '${log.sets.map((s) => s.reps).join(', ')}',
                                    ),
                                    trailing: Text(
                                        '${log.volume.toStringAsFixed(0)} kg',
                                    ),
                                ),
                            ),
                    ],
                );
            }),
        );
    }
}
