import 'dart:io';

Future<String?> writeTextFile(String path, String contents) async {
    final file = File(path);
    if (!file.existsSync()) {
        await file.writeAsString(contents);
    }
    return path;
}

Future<String?> readTextFile(String path) async {
    return await File(path).readAsString();
}

Future<bool> fileExists(String path) async {
    return File(path).existsSync();
}
