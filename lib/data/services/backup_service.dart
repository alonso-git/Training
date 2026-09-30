import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

import '../../domain/entities/exercise.dart';
import '../../domain/entities/routine.dart';
import '../../domain/entities/session.dart';
import 'database_service.dart';
import 'file_bridge.dart' as file_bridge;

class BackupService {
    BackupService(this._db);

    final DatabaseService _db;

    static const String _versionKey = 'version';

    /// Validates the JSON and checks required structure.
    static BackupValidation validateContents(String contents) {
        Map<String, dynamic> decoded;
        try {
            decoded = jsonDecode(contents) as Map<String, dynamic>;
        } on FormatException {
            return BackupValidation.invalid(
                'This file is not valid JSON. Nothing was changed.',
            );
        } catch (_) {
            return BackupValidation.invalid(
                'This file is not valid JSON. Nothing was changed.',
            );
        }
        try {
            BackupData.fromJson(decoded);
        } catch (_) {
            return BackupValidation.invalid(
                'This file is not a valid workout backup. Nothing was changed.',
            );
        }
        return BackupValidation.valid(
            filePath: null,
            contents: contents,
        );
    }

    Future<String> exportData() async {
        final routines = await _db.routines.getAll();
        final exercises = await _db.exercises.getAll();
        final sessions = await _db.sessions.getAll();
        final map = <String, dynamic>{
            _versionKey: BackupData.currentVersion,
            'routines': routines.map((r) => r.toJson()).toList(),
            'exercises': exercises.map((e) => e.toJson()).toList(),
            'sessions': sessions.map((s) => s.toJson()).toList(),
        };
        final json = const JsonEncoder.withIndent('  ').convert(map);
        return json;
    }

    /// Exports through the platform save dialog. The path is written through
    /// the [FileBridge] on native; on web the bytes download directly.
    Future<String?> exportToFile() async {
        final json = await exportData();
        final data = Uint8List.fromList(utf8.encode(json));
        final baseName =
            'workout_backup_${DateTime.now().toIso8601String().substring(0, 10)}'
            '.json';
        final selected = await FilePicker.saveFile(
            fileName: baseName,
            bytes: data,
            type: FileType.custom,
            allowedExtensions: ['json'],
        );
        if (selected == null) {
            return null;
        }
        await file_bridge.writeTextFile(selected, json);
        return selected;
    }

    /// Opens a file picker, then validates the chosen file without touching
    /// existing data.
    Future<BackupValidation> pickAndValidate() async {
        final result = await FilePicker.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['json'],
            withData: true,
        );
        final files = result?.files ?? const [];
        if (files.isEmpty) {
            return BackupValidation.cancelled();
        }
        final picked = files.first;
        final contents = picked.bytes != null
            ? utf8.decode(picked.bytes!)
            : await _read(picked.path);
        if (contents == null) {
            return BackupValidation.invalid('Could not read the selected file.');
        }
        return BackupValidation.valid(
            filePath: picked.name,
            contents: contents,
        );
    }

    static Future<String?> _read(String? path) async {
        if (path == null) {
            return null;
        }
        try {
            return await file_bridge.readTextFile(path);
        } catch (_) {
            return null;
        }
    }

    /// Replaces all stored data with the given backup JSON (after
    /// [validateContents] passed) and re-seeds the exercise catalog.
    Future<void> restoreFromFile(String contents) async {
        final backup = _parseOrThrow(contents);
        await _db.clearAll();
        for (final exercise in backup.exercises) {
            final exists = await _db.exercises.existsByName(exercise.name);
            if (!exists) {
                await _db.exercises.save(exercise);
            }
        }
        for (final routine in backup.routines) {
            await _db.routines.save(routine);
        }
        for (final session in backup.sessions) {
            await _db.sessions.save(session);
        }
    }

    BackupData _parseOrThrow(String contents) {
        final map = jsonDecode(contents);
        if (map is! Map<String, dynamic>) {
            throw const FormatException('Backup root must be a JSON object');
        }
        return BackupData.fromJson(map);
    }
}

enum BackupStatus {
    cancelled,
    validData,
    invalidJson,
    invalidStructure,
    unreadable,
}

class BackupValidation {
    const BackupValidation._({
        required this.status,
        required this.error,
        this.filePath,
        this.contents,
    });

    factory BackupValidation.cancelled() {
        return const BackupValidation._(status: BackupStatus.cancelled, error: '');
    }

    factory BackupValidation.invalid(String message) {
        return BackupValidation._(status: BackupStatus.invalidJson, error: message);
    }

    factory BackupValidation.valid({
        required String? filePath,
        required String? contents,
    }) {
        return BackupValidation._(
            status: BackupStatus.validData,
            error: '',
            filePath: filePath,
            contents: contents,
        );
    }

    final BackupStatus status;
    final String error;
    final String? filePath;
    final String? contents;

    bool get isValid => status == BackupStatus.validData;
    bool get isCancelled => status == BackupStatus.cancelled;
}

class BackupData {
    const BackupData({
        required this.version,
        required this.routines,
        required this.exercises,
        required this.sessions,
    });

    final int version;
    final List<Routine> routines;
    final List<Exercise> exercises;
    final List<Session> sessions;

    static const int currentVersion = 1;

    static BackupData fromJson(Map<String, dynamic> json) {
        return BackupData(
            version: (json['version'] as num?)?.toInt() ?? currentVersion,
            routines: (json['routines'] as List? ?? const [])
                .map((r) => Routine.fromJson(Map<String, dynamic>.from(r as Map)))
                .toList(),
            exercises: (json['exercises'] as List? ?? const [])
                .map(
                    (e) => Exercise.fromJson(
                        Map<String, dynamic>.from(e as Map),
                    ),
                )
                .toList(),
            sessions: (json['sessions'] as List? ?? const [])
                .map(
                    (s) => Session.fromJson(
                        Map<String, dynamic>.from(s as Map),
                    ),
                )
                .toList(),
        );
    }
}
