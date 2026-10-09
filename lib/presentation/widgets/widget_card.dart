import 'package:flutter/material.dart';

/// Widget-like visual language shared across screens.
///
/// A [WidgetCard] is a rounded tile with a hairline border on the dark
/// surface - the basic "widget" element of the profile-driven home.
class WidgetCard extends StatelessWidget {
    const WidgetCard({
        required this.child,
        this.padding = const EdgeInsets.all(16),
        this.onTap,
        this.accentGradient = false,
        super.key,
    });

    final Widget child;
    final EdgeInsetsGeometry padding;
    final VoidCallback? onTap;

    /// Adds a subtle horizontal accent strip behind the content.
    final bool accentGradient;

    @override
    Widget build(BuildContext context) {
        final theme = Theme.of(context);
        final scheme = theme.colorScheme;
        final body = Padding(
            padding: padding,
            child: child,
        );
        final decorated = accentGradient
            ? Container(
                decoration: BoxDecoration(
                    color: scheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: scheme.outlineVariant),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                            scheme.primary.withValues(alpha: 0.08),
                            Colors.transparent,
                        ],
                        stops: const [0, 0.35],
                    ),
                ),
                child: body,
            )
            : Card(child: body);
        if (onTap == null) {
            return decorated;
        }
        return InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: decorated,
        );
    }
}

/// Compact metric tile used inside widget rows (streak, volume, sessions).
class StatChip extends StatelessWidget {
    const StatChip({
        required this.icon,
        required this.label,
        required this.value,
        this.color,
        super.key,
    });

    final IconData icon;
    final String label;
    final String value;
    final Color? color;

    @override
    Widget build(BuildContext context) {
        final theme = Theme.of(context);
        final scheme = theme.colorScheme;
        final tint = color ?? scheme.primary;
        return Expanded(
            child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: scheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: scheme.outlineVariant),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Icon(icon, size: 18, color: tint),
                        const SizedBox(height: 8),
                        Text(
                            value,
                            style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                            ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                            label,
                            style: theme.textTheme.labelSmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}

/// Widget-style week plan: one pill per weekday (starting Monday). Days
/// configured as training days in the profile are highlighted.
class WeekStrip extends StatelessWidget {
    const WeekStrip({
        required this.trainingDays,
        required this.todayWeekday,
        this.todayIsTrainingDay,
        super.key,
    });

    /// Profile training days, 0 = Sunday ... 6 = Saturday.
    final List<int> trainingDays;

    /// DateTime.weekday of today (1 = Monday ... 7 = Sunday).
    final int todayWeekday;

    /// Overrides whether today is treated as planned (used when a routine
    /// is scheduled today).
    final bool? todayIsTrainingDay;

    static const List<String> _labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    @override
    Widget build(BuildContext context) {
        final theme = Theme.of(context);
        final scheme = theme.colorScheme;
        // Monday-ordered labels; weekday slot i maps to profile day
        // ((i + 1) % 7) where 0 = Sunday.
        return Row(
            children: [
                for (var i = 0; i < 7; i++)
                    Expanded(
                        child: _WeekPill(
                            label: _labels[i],
                            isPlanned: trainingDays
                                .contains((i + 1) % 7),
                            isToday: (i + 1) == todayWeekday,
                            todayEffective: todayIsTrainingDay,
                            scheme: scheme,
                            textStyle: theme.textTheme.labelSmall,
                        ),
                    ),
            ],
        );
    }
}

class _WeekPill extends StatelessWidget {
    const _WeekPill({
        required this.label,
        required this.isPlanned,
        required this.isToday,
        required this.todayEffective,
        required this.scheme,
        required this.textStyle,
    });

    final String label;
    final bool isPlanned;
    final bool isToday;
    final bool? todayEffective;
    final ColorScheme scheme;
    final TextStyle? textStyle;

    bool get _highlight {
        if (isToday && todayEffective != null) {
            return todayEffective!;
        }
        return isPlanned;
    }

    @override
    Widget build(BuildContext context) {
        final background = _highlight
            ? scheme.primary.withValues(alpha: isToday ? 1 : 0.22)
            : scheme.surfaceContainerHigh;
        final foreground =
            _highlight && scheme.brightness == Brightness.dark && isToday
                ? scheme.onPrimary
                : scheme.onSurfaceVariant;
        return Container(
            margin: const EdgeInsets.only(right: 6),
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: isToday
                        ? scheme.primary
                        : scheme.outlineVariant,
                    width: isToday ? 1.6 : 1,
                ),
            ),
            child: Text(
                label,
                style: textStyle?.copyWith(color: foreground),
            ),
        );
    }
}
