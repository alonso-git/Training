import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../domain/entities/profile.dart';
import '../state/profile_state.dart';
import '../view_models/profile_view_model.dart';
import '../widgets/widget_card.dart';

/// Profile module: personalization of the whole app (name, weekly
/// training days, theme/AMOLED preferences).
class ProfileScreen extends StatefulWidget {
    const ProfileScreen({super.key});

    @override
    State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
    ProfileViewModel? _vm;

    @override
    void initState() {
        super.initState();
        _bootstrap();
    }

    Future<void> _bootstrap() async {
        await ProfileState.load();
        if (mounted) {
            setState(() {
                _vm = ProfileViewModel(ProfileState.profile.value);
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        final vm = _vm;
        if (vm == null) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
            );
        }
        return SignalBuilder(
            builder: (context) {
                final current = _vm!.current;
                return Scaffold(
                    appBar: AppBar(
                        title: const Text('Profile'),
                        actions: [
                            IconButton(
                                icon: const Icon(Icons.check),
                                tooltip: 'Save profile',
                                onPressed: () => _save(),
                            ),
                        ],
                    ),
                    body: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                            _identitySection(context, current),
                            const SizedBox(height: 16),
                            _trainingDaysSection(context, current),
                            const SizedBox(height: 16),
                            _appearanceSection(context, current),
                        ],
                    ),
                );
            },
        );
    }

    Widget _identitySection(BuildContext context, Profile current) {
        return WidgetCard(
            accentGradient: true,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    _sectionHeader(context, Icons.person, 'Who is training?'),
                    const SizedBox(height: 12),
                    TextFormField(
                        initialValue: current.name,
                        decoration: const InputDecoration(
                            labelText: 'Name',
                            hintText: 'Shown on your home dashboard',
                            prefixIcon: Icon(Icons.badge),
                        ),
                        maxLength: 40,
                        onChanged: (value) => _vm!.setName(value),
                        onFieldSubmitted: (_) => _save(),
                    ),
                ],
            ),
        );
    }

    Widget _trainingDaysSection(BuildContext context, Profile current) {
        final theme = Theme.of(context);
        return WidgetCard(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    _sectionHeader(
                        context,
                        Icons.event_available,
                        'Training days',
                    ),
                    const SizedBox(height: 4),
                    Text(
                        'Feeds the week widget on your dashboard.',
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                        ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                            for (var day = 0; day < 7; day++)
                                FilterChip(
                                    label: Text(
                                        ProfileLimits.dayNames[day],
                                    ),
                                    selected:
                                        current.trainingDays.contains(day),
                                    onSelected: (_) async {
                                        setState(() => _vm!.toggleDay(day));
                                        await _vm!.save();
                                    },
                                ),
                        ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                        '${current.trainingDays.length} of 7 days selected',
                        style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                        ),
                    ),
                ],
            ),
        );
    }

    Widget _appearanceSection(BuildContext context, Profile current) {
        return WidgetCard(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    _sectionHeader(context, Icons.palette, 'Appearance'),
                    const SizedBox(height: 12),
                    SegmentedButton<int>(
                        segments: const [
                            ButtonSegment(
                                value: 0,
                                icon: Icon(Icons.brightness_auto),
                                label: Text('System'),
                            ),
                            ButtonSegment(
                                value: 1,
                                icon: Icon(Icons.light_mode),
                                label: Text('Light'),
                            ),
                            ButtonSegment(
                                value: 2,
                                icon: Icon(Icons.dark_mode),
                                label: Text('Dark'),
                            ),
                        ],
                        selected: {current.themeModeIndex},
                        onSelectionChanged: (selection) async {
                            setState(
                                () => _vm!.setThemeMode(
                                    ThemeMode.values[selection.first],
                                ),
                            );
                            await _vm!.save();
                        },
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        secondary: const Icon(Icons.contrast),
                        title: const Text('AMOLED mode'),
                        subtitle: const Text(
                            'Pure black background with high-contrast '
                            'accent widgets.',
                        ),
                        value: current.amoled,
                        onChanged: (value) async {
                            setState(() => _vm!.setAmoled(value));
                            await _vm!.save();
                        },
                    ),
                ],
            ),
        );
    }

    Widget _sectionHeader(
        BuildContext context,
        IconData icon,
        String title,
    ) {
        final theme = Theme.of(context);
        return Row(
            children: [
                Icon(icon, size: 18, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                    title,
                    style: theme.textTheme.titleMedium,
                ),
            ],
        );
    }

    Future<void> _save() async {
        final messenger = ScaffoldMessenger.of(context);
        await _vm!.save();
        messenger.showSnackBar(
            const SnackBar(content: Text('Profile saved.')),
        );
    }
}
