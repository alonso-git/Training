import 'database_factory_isar.dart'
    if (dart.library.html) 'database_factory_web.dart' as impl;
import 'database_service.dart';

/// Creates the platform-appropriate database: Isar on native, a
/// localStorage-backed equivalent on web, both behind [DatabaseService].
Future<DatabaseService> createDatabaseService() {
    return impl.createDatabaseService();
}
