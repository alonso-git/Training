import 'dart:io';

import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

/// In-memory path provider so tests can open Isar in a temp directory
/// without touching the platform.
class FakePathProviderPlatform extends PathProviderPlatform {
    FakePathProviderPlatform(this.baseDir);

    final Directory baseDir;

    @override
    Future<String?> getApplicationDocumentsPath() async {
        return baseDir.path;
    }

    @override
    Future<String?> getTemporaryPath() async {
        return baseDir.createTempSync('tmp').path;
    }

    @override
    Future<String?> getLibraryPath() async {
        return baseDir.path;
    }

    @override
    Future<String?> getApplicationSupportPath() async {
        return baseDir.path;
    }

    @override
    Future<String?> getDownloadsPath() async {
        return null;
    }

    @override
    Future<String?> getExternalStoragePath() async {
        return null;
    }
}
