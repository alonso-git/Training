import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

import '../../data/services/backup_service.dart';
import '../../data/services/database_service.dart';
import '../state/profile_state.dart';
import '../view_models/settings_view_model.dart';

class SettingsScreen extends StatefulWidget {
    const SettingsScreen({required this.backup, required this.database, super.key});

    final BackupService backup;
    final DatabaseService database;

    @override
    State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
    late final SettingsViewModel _vm;

    @override
    void initState() {
        super.initState();
        _vm = SettingsViewModel(widget.backup, widget.database);
        ProfileState.load();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title: const Text('Settings')),
            body: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                    Text('Profile', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    SignalBuilder(builder: (context) {
                        final profile = ProfileState.profile.value;
                        return Card(
                            child: ListTile(
                                leading: const Icon(Icons.person),
                                title: Text(
                                    '${profile.displayName}'
                                    ' · '
                                    '${profile.trainingDays.length} training'
                                    ' days',
                                ),
                                subtitle: Text(
                                    '${profile.themeMode.name} theme'
                                    '${profile.amoled ? ' · AMOLED' : ''}',
                                ),
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () => context.push('/profile'),
                            ),
                        );
                    }),
                    const SizedBox(height: 16),
                    Text('Data', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Card(
                        child: Column(
                            children: [
                                ListTile(
                                    leading: const Icon(Icons.file_download),
                                    title: const Text('Export data'),
                                    subtitle: const Text(
                                        'Save all routines, exercises and '
                                        'sessions as a JSON file.',
                                    ),
                                    onTap: _export,
                                ),
                                const Divider(height: 1),
                                ListTile(
                                    leading: const Icon(Icons.file_upload),
                                    title: const Text('Import data'),
                                    subtitle: const Text(
                                        'Restore a previously exported JSON '
                                        'backup. Replaces all existing data.',
                                    ),
                                    onTap: _import,
                                ),
                            ],
                        ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                        child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                        'App info',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                        'Version: ${SettingsViewModel.appVersion}',
                                    ),
                                ],
                            ),
                        ),
                    ),
                    const SizedBox(height: 16),
                    SignalBuilder(builder: (context2) {
                        final message = _vm.message.value;
                        final error = _vm.error.value;
                        if (error != null) {
                            return Text(
                                error,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.error,
                                ),
                            );
                        }
                        if (message != null) {
                            return Text(message);
                        }
                        return const SizedBox.shrink();
                    }),
                    const Center(
                        child: Padding(
                            padding: EdgeInsets.all(24),
                            child: SizedBox(width: 24),
                        ),
                    ),
                ],
            ),
        );
    }

    Future<void> _export() async {
        final path = await _vm.exportData();
        if (mounted && path != null) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Exported to $path')),
            );
        }
    }

    Future<void> _import() async {
        final validation = await _vm.pickImportFile();
        if (!mounted || validation.isCancelled) {
            return;
        }
        if (!validation.isValid) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(validation.error)),
            );
            return;
        }
        final confirmed = await showDialog<bool>(
            context: context,
            builder: (context) {
                return AlertDialog(
                    title: const Text('Import data?'),
                    content: const Text(
                        'This will replace all existing data with the '
                        'contents of the selected file. Exported data cannot '
                        'be recovered.',
                    ),
                    actions: [
                        TextButton(
                            onPressed: () =>
                                Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                        ),
                        FilledButton(
                            onPressed: () =>
                                Navigator.of(context).pop(true),
                            child: const Text('Import'),
                        ),
                    ],
                );
            },
        );
        if (confirmed != true) {
            return;
        }
        final ok = await _vm.restore(validation.contents ?? '');
        if (!mounted) {
            return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    ok
                        ? _vm.message.value ?? 'Imported.'
                        : _vm.error.value ?? 'Import failed.',
                ),
            ),
        );
    }
}

