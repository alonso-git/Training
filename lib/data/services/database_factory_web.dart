import 'dart:convert';
import 'dart:js_interop';

import 'database_service.dart';
import 'local_database_service.dart';

const String storageKey = 'nuthy_workout_db';

@JS('window.localStorage.getItem')
external JSString? _storageRead(JSString key);

@JS('window.localStorage.setItem')
external void _storageWrite(JSString key, JSString value);

/// Web storage: mirrors the local database state into localStorage.
Future<DatabaseService> createDatabaseService() {
    final stored = _storageRead(storageKey.toJS);
    final json = stored?.toDart;
    if (json == null || json.isEmpty) {
        final service = LocalDatabaseService(
            persist: (state) =>
                _storageWrite(storageKey.toJS, state.toJS),
        );
        return Future.value(service);
    }
    final restored = LocalDatabaseService.fromState(
        jsonDecode(json) as Map<String, dynamic>,
        persist: (state) => _storageWrite(storageKey.toJS, state.toJS),
    );
    return Future.value(restored);
}
