import 'database_service.dart';
import 'isar_database_service.dart';

/// Native platforms: real Isar storage with local file directories.
Future<DatabaseService> createDatabaseService() async {
    final service = IsarDatabaseService();
    await service.init();
    return service;
}
