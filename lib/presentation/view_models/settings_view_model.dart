import 'package:signals/signals.dart';

import '../../data/services/backup_service.dart';
import '../../data/services/database_service.dart';

/// State for the settings screen: export/import plus app info.
class SettingsViewModel {
    SettingsViewModel(this._backup, this._database);

    final BackupService _backup;
    final DatabaseService _database;

    final busy = signal<bool>(false);
    final message = signal<String?>(null);
    final error = signal<String?>(null);

    static const String appVersion = '1.0.0';

    /// Exports all data; returns the written file path or null when
    /// cancelled by the user.
    Future<String?> exportData() async {
        busy.value = true;
        message.value = null;
        error.value = null;
        try {
            final path = await _backup.exportToFile();
            if (path != null) {
                message.value = 'Data exported successfully.';
            }
            return path;
        } catch (e) {
            error.value = 'Export failed. Please try again.';
            return null;
        } finally {
            busy.value = false;
        }
    }

    /// Opens the import picker and validates the file without touching
    /// existing data.
    Future<BackupValidation> pickImportFile() async {
        busy.value = true;
        message.value = null;
        error.value = null;
        try {
            return await _backup.pickAndValidate();
        } finally {
            busy.value = false;
        }
    }

    /// Performs the import after the confirmation dialog. Returns true on
    /// success; on invalid JSON the database is left untouched.
    Future<bool> restore(String contents) async {
        busy.value = true;
        try {
            final validation = BackupService.validateContents(contents);
            if (!validation.isValid) {
                error.value = validation.error;
                return false;
            }
            await _backup.restoreFromFile(contents);
            message.value = 'Data imported successfully. Old data was replaced.';
            return true;
        } catch (e) {
            error.value =
                'This file is not a valid backup. Nothing was changed.';
            return false;
        } finally {
            busy.value = false;
        }
    }

    Future<int> dataSize() {
        return _database.dataSizeBytes();
    }

    void clearMessages() {
        message.value = null;
        error.value = null;
    }
}
