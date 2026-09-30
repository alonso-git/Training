/// Web variant: no dart:io file system. Export content moves through the
/// FilePicker (download), import content comes from picked bytes.
Future<String?> writeTextFile(String path, String contents) async {
    return path;
}

Future<String?> readTextFile(String path) async {
    throw UnsupportedError(
        'Direct file reading is unavailable on web; files are read through '
        'FilePicker with bytes.',
    );
}

Future<bool> fileExists(String path) async {
    return path.isNotEmpty;
}
