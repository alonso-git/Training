import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

import '../../core/utils/date_utils.dart' as d;
import '../view_models/progress_view_model.dart';

class ProgressScreen extends StatefulWidget {
    const ProgressScreen({super.key});

    @override
    State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
    final _vm = ProgressViewModel();

    @override
    void initState() {
        super.initState();
        _vm.load();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Progress')),
            body: SignalBuilder(builder: (context2) {
                if (_vm.loading.value) {
                    return const Center(child: CircularProgressIndicator());
                }
                final exercises = _vm.exercises.value;
                return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                        Text(
                            'Weight progression',
                            style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                            initialValue: _vm.selectedExerciseId.value,
                            hint: const Text('Select exercise'),
                            items: [
                                for (final e in exercises)
                                    DropdownMenuItem(
                                        value: e.id,
                                        child: Text(e.name),
                                    ),
                            ],
                            onChanged: (value) {
                                if (value != null) {
                                    _vm.selectExercise(value);
                                }
                            },
                        ),
                        const SizedBox(height: 8),
                        SignalBuilder(
                            builder: (context2) {
                                final id = _vm.selectedExerciseId.value;
                                final name = _vm.exercises.value
                                    .where((e) => e.id == id)
                                    .map((e) => e.name)
                                    .firstOrNull;
                                if (id == null) {
                                    return const SizedBox.shrink();
                                }
                                return TextButton(
                                    onPressed: () => context.push(
                                        '/exercises/detail/$id?name=$name',
                                    ),
                                    child: const Text(
                                        'View all sessions for this exercise',
                                    ),
                                );
                            },
                        ),
                        _weightChart(context),
                        const SizedBox(height: 24),
                        Text(
                            'Total volume per session',
                            style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        _volumeChart(context),
                        const SizedBox(height: 24),
                        Text(
                            'Sessions per week',
                            style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        _frequencyChart(context),
                    ],
                );
            }),
        );
    }

    Widget _placeholderCard(BuildContext context, String text) {
        return Card(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(text),
            ),
        );
    }

    Widget _weightChart(BuildContext context) {
        final points = _vm.weightPoints.value;
        if (points.isEmpty) {
            return _placeholderCard(
                context,
                'Select an exercise to see its weight progression over time.',
            );
        }
        final spots = <FlSpot>[
            for (var i = 0; i < points.length; i++)
                FlSpot(i.toDouble(), points[i].weight),
        ];
        final maxYRaw = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
        return Card(
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                    height: 220,
                    child: LineChart(
                        LineChartData(
                            minY: 0,
                            maxY: (maxYRaw + 5).ceilToDouble(),
                            gridData: const FlGridData(show: true),
                            borderData: FlBorderData(
                                border: Border.all(
                                    color: Colors.grey.withValues(alpha: 0.4),
                                ),
                            ),
                            titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        reservedSize: 28,
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) =>
                                            _xLabel(
                                                context,
                                                value,
                                                meta,
                                                points.length,
                                                (i) => d.AppDateUtils.formatDate(
                                                    points[i].date,
                                                ),
                                            ),
                                    ),
                                ),
                                rightTitles: _noTitles,
                                topTitles: _noTitles,
                            ),
                            lineBarsData: [
                                LineChartBarData(
                                    spots: spots,
                                    isCurved: false,
                                    dotData: const FlDotData(show: true),
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }

    Widget _volumeChart(BuildContext context) {
        var points = _vm.volumePoints.value;
        if (points.isEmpty) {
            return _placeholderCard(context, 'No sessions logged yet.');
        }
        points = points.length > 12 ? points.sublist(0, 12) : points;
        final maxYRaw = points
            .map((p) => p.volume)
            .reduce((a, b) => a > b ? a : b);
        return Card(
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                    height: 220,
                    child: BarChart(
                        BarChartData(
                            barGroups: [
                                for (var i = 0; i < points.length; i++)
                                    BarChartGroupData(
                                        x: i,
                                        barRods: [
                                            BarChartRodData(
                                                toY: points[i].volume,
                                                width: 16,
                                            ),
                                        ],
                                    ),
                            ],
                            maxY: (maxYRaw + 50).ceilToDouble(),
                            gridData: const FlGridData(show: true),
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        reservedSize: 28,
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) =>
                                            _xLabel(
                                                context,
                                                value,
                                                meta,
                                                points.length,
                                                (i) => points[i].label,
                                            ),
                                    ),
                                ),
                                rightTitles: _noTitles,
                                topTitles: _noTitles,
                            ),
                        ),
                    ),
                ),
            ),
        );
    }

    Widget _frequencyChart(BuildContext context) {
        final points = _vm.frequencyPoints.value;
        if (points.isEmpty) {
            return _placeholderCard(context, 'No sessions to show yet.');
        }
        final maxYRaw = points
            .map((p) => p.count)
            .reduce((a, b) => a > b ? a : b)
            .toDouble();
        return Card(
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                    height: 220,
                    child: BarChart(
                        BarChartData(
                            barGroups: [
                                for (var i = 0; i < points.length; i++)
                                    BarChartGroupData(
                                        x: i,
                                        barRods: [
                                            BarChartRodData(
                                                toY: points[i].count
                                                    .toDouble(),
                                                width: 20,
                                            ),
                                        ],
                                    ),
                            ],
                            maxY: maxYRaw + 1,
                            gridData: const FlGridData(show: true),
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                                bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        reservedSize: 28,
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) =>
                                            _xLabel(
                                                context,
                                                value,
                                                meta,
                                                points.length,
                                                (i) => points[i].label,
                                            ),
                                    ),
                                ),
                                rightTitles: _noTitles,
                                topTitles: _noTitles,
                            ),
                        ),
                    ),
                ),
            ),
        );
    }

    static const AxisTitles _noTitles = AxisTitles(
        sideTitles: SideTitles(showTitles: false),
    );

    Widget _xLabel(
        BuildContext context,
        double value,
        TitleMeta meta,
        int count,
        String Function(int) labelOf,
    ) {
        final i = value.toInt();
        if (i < 0 || i >= count) {
            return const SizedBox.shrink();
        }
        return SideTitleWidget(
            meta: meta,
            child: Text(
                labelOf(i),
                style: Theme.of(context).textTheme.labelSmall,
            ),
        );
    }
}
