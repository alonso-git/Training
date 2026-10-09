import 'dart:convert';

import '../../domain/entities/exercise.dart';
import '../../domain/entities/profile.dart';
import '../../domain/entities/routine.dart';
import '../../domain/entities/session.dart';
import '../../domain/repositories/exercise_repository.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/repositories/routine_repository.dart';
import '../../domain/repositories/session_repository.dart';
import 'database_service.dart';
import 'exercise_catalog_seed.dart';

/// In-memory storage used on web (Isar's generated schemas cannot compile to
/// JS). The full state is mirrored to a persistence callback as JSON on every
/// write.
class LocalDatabaseService implements DatabaseService {
    LocalDatabaseService({void Function(String json)? persist})
        : _persist = persist,
          _exerciseData = [],
          _routineData = [],
          _sessionData = [],
          _profileData = [Profile.defaultProfile()] {
        _exerciseRepository = _LocalExerciseRepository(_exerciseData, _apply);
        _routineRepository = _LocalRoutineRepository(_routineData, _apply);
        _sessionRepository = _LocalSessionRepository(_sessionData, _apply);
        _profileRepository = _LocalProfileRepository(_profileData, _apply);
    }

    /// Rebuilds the service from a previously persisted JSON snapshot.
    LocalDatabaseService.fromState(
        Map<String, dynamic> state, {
        void Function(String json)? persist,
    })
        : _persist = persist,
          _exerciseData = (state['exercises'] as List? ?? const [])
              .map(
                  (e) => Exercise.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList(),
          _routineData = (state['routines'] as List? ?? const [])
              .map(
                  (r) => Routine.fromJson(Map<String, dynamic>.from(r as Map)),
              )
              .toList(),
          _sessionData = (state['sessions'] as List? ?? const [])
              .map(
                  (s) => Session.fromJson(Map<String, dynamic>.from(s as Map)),
              )
              .toList(),
          _profileData = [
            if (state['profile'] != null)
              Profile.fromJson(
                  Map<String, dynamic>.from(state['profile'] as Map))
            else
              Profile.defaultProfile(),
          ] {
        _exerciseRepository = _LocalExerciseRepository(_exerciseData, _apply);
        _routineRepository = _LocalRoutineRepository(_routineData, _apply);
        _sessionRepository = _LocalSessionRepository(_sessionData, _apply);
        _profileRepository = _LocalProfileRepository(_profileData, _apply);
        if (!_exerciseData.any((e) => !e.isCustom)) {
            _seedCatalog();
        }
    }

    final void Function(String json)? _persist;

    late final _LocalExerciseRepository _exerciseRepository;
    late final _LocalRoutineRepository _routineRepository;
    late final _LocalSessionRepository _sessionRepository;
    late final _LocalProfileRepository _profileRepository;

    final List<Exercise> _exerciseData;
    final List<Routine> _routineData;
    final List<Session> _sessionData;
    final List<Profile> _profileData;

    @override
    ExerciseRepository get exercises => _exerciseRepository;

    @override
    RoutineRepository get routines => _routineRepository;

    @override
    SessionRepository get sessions => _sessionRepository;

    @override
    ProfileRepository get profiles => _profileRepository;

    @override
    Future<void> init() async {
        if (!_exerciseData.any((e) => !e.isCustom)) {
            _seedCatalog();
        }
        _apply();
    }

    void _seedCatalog() {
        _exerciseData.addAll(ExerciseCatalogSeed.catalog);
    }

    void _apply() {
        _persist?.call(jsonEncode(exportState()));
    }

    Map<String, dynamic> exportState() {
        return {
            'routines': _routineData.map((r) => r.toJson()).toList(),
            'exercises': _exerciseData.map((e) => e.toJson()).toList(),
            'sessions': _sessionData.map((s) => s.toJson()).toList(),
            'profile': _defaultProfile().toJson(),
        };
    }

    Profile _defaultProfile() {
        return _profileData.isEmpty
            ? Profile.defaultProfile()
            : _profileData.first;
    }

    /// Drops everything and re-seeds the predefined exercise catalog.
    @override
    Future<void> clearAll() async {
        _exerciseData.clear();
        _routineData.clear();
        _sessionData.clear();
        _seedCatalog();
        _apply();
    }

    @override
    Future<int> dataSizeBytes() {
        return Future.value(jsonEncode(exportState()).length);
    }
}

class _LocalExerciseRepository implements ExerciseRepository {
    _LocalExerciseRepository(this._data, this._apply);

    final List<Exercise> _data;
    final void Function() _apply;

    List<Exercise> _sortedCopy() {
        return List<Exercise>.from(_data)
            ..sort((a, b) => a.name.compareTo(b.name));
    }

    @override
    Future<List<Exercise>> getAll() async => _sortedCopy();

    @override
    Future<Exercise?> getById(String id) async {
        return _whereFirst(_data, (e) => e.id == id);
    }

    @override
    Future<List<Exercise>> getByIds(List<String> ids) async {
        final idSet = Set<String>.from(ids);
        final list = _data.where((e) => idSet.contains(e.id)).toList();
        list.sort(
            (a, b) => ids.indexOf(a.id).compareTo(ids.indexOf(b.id)),
        );
        return list;
    }

    @override
    Future<void> save(Exercise exercise) async {
        final index = _data.indexWhere((e) => e.id == exercise.id);
        if (index >= 0) {
            _data[index] = exercise;
        } else {
            _data.add(exercise);
        }
        _apply();
    }

    @override
    Future<void> delete(String id) async {
        _data.removeWhere((e) => e.id == id);
        _apply();
    }

    @override
    Future<bool> existsByName(String name) async {
        return _data.any((e) => e.name.toLowerCase() == name.toLowerCase());
    }
}

class _LocalRoutineRepository implements RoutineRepository {
    _LocalRoutineRepository(this._data, this._apply);

    final List<Routine> _data;
    final void Function() _apply;

    @override
    Future<List<Routine>> getAll() async {
        return List<Routine>.from(_data)
            ..sort((a, b) => a.name.compareTo(b.name));
    }

    @override
    Future<Routine?> getById(String id) async {
        return _whereFirst(_data, (r) => r.id == id);
    }

    @override
    Future<void> save(Routine routine) async {
        final index = _data.indexWhere((r) => r.id == routine.id);
        if (index >= 0) {
            _data[index] = routine;
        } else {
            _data.add(routine);
        }
        _apply();
    }

    @override
    Future<void> delete(String id) async {
        _data.removeWhere((r) => r.id == id);
        _apply();
    }
}

class _LocalSessionRepository implements SessionRepository {
    _LocalSessionRepository(this._data, this._apply);

    final List<Session> _data;
    final void Function() _apply;

    List<Session> _sortedCopy() {
        return List<Session>.from(_data)
            ..sort((a, b) => b.date.compareTo(a.date));
    }

    @override
    Future<List<Session>> getAll() async => _sortedCopy();

    @override
    Future<Session?> getById(String id) async {
        return _whereFirst(_data, (s) => s.id == id);
    }

    @override
    Future<Session?> getLatestForExercise(String exerciseId) async {
        return (await getForExercise(exerciseId)).firstOrNull;
    }

    @override
    Future<List<Session>> getForExercise(String exerciseId) async {
        return _sortedCopy()
            .where(
                (s) => s.exerciseLogs.any((l) => l.exerciseId == exerciseId),
            )
            .toList();
    }

    @override
    Future<List<Session>> getSince(DateTime date) async {
        return _sortedCopy().where((s) => s.date.isAfter(date)).toList();
    }

    @override
    Future<void> save(Session session) async {
        final index = _data.indexWhere((s) => s.id == session.id);
        if (index >= 0) {
            _data[index] = session;
        } else {
            _data.add(session);
        }
        _apply();
    }

    @override
    Future<void> delete(String id) async {
        _data.removeWhere((s) => s.id == id);
        _apply();
    }
}

class _LocalProfileRepository implements ProfileRepository {
    _LocalProfileRepository(this._data, this._apply);

    final List<Profile> _data;
    final void Function() _apply;

    @override
    Future<Profile> get() async {
        if (_data.isEmpty) {
            final fresh = Profile.defaultProfile();
            _data.add(fresh);
            _apply();
            return fresh;
        }
        return _data.first;
    }

    @override
    Future<void> save(Profile profile) async {
        final stored = Profile(
            id: Profile.localId,
            name: profile.name,
            trainingDays: List<int>.from(profile.trainingDays),
            themeModeIndex: profile.themeModeIndex,
            amoled: profile.amoled,
        );
        if (_data.isEmpty) {
            _data.add(stored);
        } else {
            _data[0] = stored;
        }
        _apply();
    }
}

T? _whereFirst<T>(Iterable<T> list, bool Function(T) test) {
    for (final e in list) {
        if (test(e)) {
            return e;
        }
    }
    return null;
}
