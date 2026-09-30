import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/utils/date_utils.dart';
import '../view_models/session_view_model.dart';

class SessionSummaryScreen extends StatelessWidget {
    const SessionSummaryScreen({required this.result, super.key});

    final FinishedSession result;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Workout complete'),
                automaticallyImplyLeading: false,
            ),
            body: Center(
                child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            Icon(
                                Icons.emoji_events,
                                size: 72,
                                color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                                result.routineName,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium,
                            ),
                            const SizedBox(height: 24),
                            Card(
                                child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                        children: [
                                            _row('Total sets', '${result.totalSets}'),
                                            _row(
                                                'Total volume',
                                                '${result.volume.toStringAsFixed(1)} kg',
                                            ),
                                            _row(
                                                'Duration',
                                                AppDateUtils.formatDuration(
                                                    result.duration,
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                            const SizedBox(height: 24),
                            FilledButton.icon(
                                icon: const Icon(Icons.home),
                                label: const Text('Back to home'),
                                onPressed: () => context.go('/'),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }

    Widget _row(String label, String value) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                    SizedBox(width: 140, child: Text(label)),
                    Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
            ),
        );
    }
}
