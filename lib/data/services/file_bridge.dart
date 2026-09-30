import 'file_bridge_io.dart'
    if (dart.library.html) 'file_bridge_web.dart' as impl;

Future<String?> writeTextFile(String path, String contents) {
    return impl.writeTextFile(path, contents);
}

Future<String?> readTextFile(String path) {
    return impl.readTextFile(path);
}

Future<bool> fileExists(String path) {
    return impl.fileExists(path);
}
