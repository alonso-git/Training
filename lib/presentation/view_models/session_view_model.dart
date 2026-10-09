import 'dart:async';

import 'package:signals/signals.dart';

import '../../core/constants/app_constants.dart';
import '../../data/services/workout_service.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/exercise_log.dart';
import '../../domain/entities/routine.dart';
import '../../domain/entities/set_log.dart';

/// Reactive countdown state of the between-sets rest timer.
class RestCountdown {
    const RestCountdown({
        this.remaining = 0,
        this.total = 0,
        this.active = false,
    });

    final bool active;
    final int remaining;
    final int total;

    double get progress => total > 0 ? remaining / total : 0.0;

    static const RestCountdown off = RestCountdown();
}

/// Drives the exercise-by-exercise session flow with reactive state:
/// weight auto-fill, per-set rep logging, and finish validation.
class SessionViewModel {
    SessionViewModel({WorkoutService? workout}) :
        _workout = workout ?? WorkoutService();

    static const double _weightStep = 0.25;

    final WorkoutService _workout;

    Routine? _routine;
    List<ExerciseStartState>? _startStates;

    final started = signal<bool>(false);
    final loading = signal<bool>(false);
    final currentIndex = signal<int>(0);
    final weight = signal<double>(0.0);
    final currentSetIndex = signal<int>(0);
    final pendingLogs = signal<List<ExerciseLogDraft>>([]);
    final error = signal<String?>(null);
    final rest = signal<RestCountdown>(RestCountdown.off);

    final Stopwatch _stopwatch = Stopwatch();
    Timer? _restTimer;

    ExerciseStartState? get currentStartState =>
        _startStates == null || _startStates!.isEmpty
            ? null
            : _startStates![currentIndex.value];

    List<ExerciseStartState> get startStates => _startStates ?? const [];

    /// Starts the session flow for a routine: preloads all exercise states.
    Future<void> start(Routine routine) async {
        error.value = null;
        loading.value = true;
        _routine = routine;
        final states = <ExerciseStartState>[];
        for (final id in routine.exerciseIds) {
            states.add(await _workout.prepareExercise(id));
        }
        _startStates = states;
        pendingLogs.value = List.filled(
            states.length,
            ExerciseLogDraft.empty(),
            growable: true,
        );
        currentIndex.value = 0;
        weight.value = states.isEmpty ? 0.0 : states.first.suggestedWeight;
        currentSetIndex.value = 0;
        _stopwatch.reset();
        _stopwatch.start();
        loading.value = false;
        started.value = true;
        cancelRest();
    }

    void setWeight(double value) {
        weight.value =
            value.clamp(AppConstants.minWeightKg, AppConstants.maxWeightKg)
                .toDouble();
    }

    void incrementWeight() {
        weight.value = weight.value + _weightStep;
    }

    void decrementWeight() {
        final next = weight.value - _weightStep;
        weight.value = next < 0 ? 0.0 : next;
    }

    /// Records the current set's reps and moves to the next set.
    /// Extra logs beyond the target number of sets are ignored.
    void logCurrentSet(int reps) {
        final index = currentIndex.value;
        final state = currentStartState;
        if (state == null || reps <= 0) {
            return;
        }
        final draft = pendingLogs.value[index];
        if (draft.setLogs.length >= state.exercise.sets) {
            return;
        }
        pendingLogs.value[index] = draft.addSet(SetLog(reps: reps));
        final setsLogged = pendingLogs.value[index].setLogs.length;
        if (setsLogged < state.exercise.sets) {
            currentSetIndex.value = setsLogged;
            _startRestFor(state.exercise);
        }
    }

    /// Starts the configured rest countdown for [exercise] after a logged
    /// set, when more sets remain and the exercise opted into the timer.
    void _startRestFor(Exercise exercise) {
        final seconds = exercise.restSeconds;
        if (seconds <= 0) {
            rest.value = RestCountdown.off;
            return;
        }
        _restTimer?.cancel();
        rest.value = RestCountdown(
            remaining: seconds,
            total: seconds,
            active: true,
        );
        _restTimer = Timer.periodic(const Duration(seconds: 1), (_) {
            final current = rest.value;
            if (!current.active) {
                _restTimer?.cancel();
                return;
            }
            final next = current.remaining - 1;
            rest.value = next <= 0
                ? RestCountdown.off
                : RestCountdown(
                    remaining: next,
                    total: current.total,
                    active: true,
                );
            if (next <= 0) {
                _restTimer?.cancel();
            }
        });
    }

    /// Adds [seconds] to the running countdown (rest extension buttons).
    void extendRest(int seconds) {
        final current = rest.value;
        if (!current.active) {
            return;
        }
        final added = current.remaining + seconds;
        rest.value = RestCountdown(
            remaining: added,
            total: current.total + seconds,
            active: true,
        );
    }

    /// Dismisses the countdown entirely.
    void skipRest() {
        _restTimer?.cancel();
        rest.value = RestCountdown.off;
    }

    /// Cancels any running countdown (exercise change / finish / abandon).
    void cancelRest() {
        _restTimer?.cancel();
        rest.value = RestCountdown.off;
    }

    /// Stops pending timers; call from the owning screen's dispose.
    void dispose() {
        _restTimer?.cancel();
    }

    void undoLastSet() {
        final index = currentIndex.value;
        final draft = pendingLogs.value[index];
        if (draft.setLogs.isEmpty) {
            return;
        }
        pendingLogs.value[index] = draft.removeLast();
        currentSetIndex.value = pendingLogs.value[index].setLogs.length;
        cancelRest();
    }

    bool get isCurrentExerciseComplete {
        final state = currentStartState;
        if (state == null) {
            return false;
        }
        return pendingLogs.value[currentIndex.value].setLogs.length >=
            state.exercise.sets;
    }

    /// Moves to the next exercise, carrying over the chosen weight when the
    /// user already logged anything.
    Future<void> goToNextExercise() async {
        final next = currentIndex.value + 1;
        if (next >= startStates.length) {
            return;
        }
        cancelRest();
        currentIndex.value = next;
        final draft = pendingLogs.value[next];
        final existing = startStates[next];
        weight.value = draft.weight ?? existing.suggestedWeight;
        currentSetIndex.value = 0;
    }

    void setDraftWeightForCurrent(double value) {
        final index = currentIndex.value;
        final draft = pendingLogs.value[index];
        pendingLogs.value[index] = ExerciseLogDraft(
            setLogs: draft.setLogs,
            weight: value,
        );
    }

    bool get hasNoLoggedSets {
        for (final draft in pendingLogs.value) {
            if (draft.hasAnyPositiveReps) {
                return false;
            }
        }
        return true;
    }

    /// Saves the session. Returns null (with error set) when no set has reps.
    Future<FinishedSession?> finish() async {
        final routine = _routine;
        if (routine == null) {
            error.value = 'No routine active.';
            return null;
        }
        final logs = <ExerciseLog>[];
        for (var i = 0; i < startStates.length; i++) {
            final draft = pendingLogs.value[i];
            final state = startStates[i];
            final kept = draft.setLogs.where((s) => s.reps > 0).toList();
            if (kept.isEmpty) {
                continue;
            }
            logs.add(
                ExerciseLog(
                    exerciseId: state.exercise.id,
                    weight: draft.weight ?? state.suggestedWeight,
                    sets: List<SetLog>.unmodifiable(kept),
                ),
            );
        }
        if (logs.isEmpty) {
            error.value =
                'No sets were completed. Log at least one rep to save '
                'the session.';
            return null;
        }
        final completed = await _workout.saveSession(
            routine.id,
            _stopwatch.elapsed,
            logs,
        );
        _stopwatch.stop();
        started.value = false;
        return FinishedSession(
            routineName: completed.routineName,
            totalSets: completed.totalSets,
            volume: completed.volume,
            duration: completed.duration,
        );
    }

    void abandon() {
        _stopwatch.stop();
        cancelRest();
        started.value = false;
    }
}

class ExerciseLogDraft {
    const ExerciseLogDraft({this.setLogs = const [], this.weight});

    final List<SetLog> setLogs;
    final double? weight;

    static ExerciseLogDraft empty() {
        return const ExerciseLogDraft();
    }

    bool get hasAnyLog => setLogs.isNotEmpty;

    bool get hasAnyPositiveReps {
        for (final s in setLogs) {
            if (s.reps > 0) {
                return true;
            }
        }
        return false;
    }

    ExerciseLogDraft addSet(SetLog set) {
        return ExerciseLogDraft(setLogs: [...setLogs, set], weight: weight);
    }

    ExerciseLogDraft removeLast() {
        if (setLogs.length <= 1) {
            return ExerciseLogDraft(weight: weight);
        }
        return ExerciseLogDraft(
            setLogs: setLogs.sublist(0, setLogs.length - 1),
            weight: weight,
        );
    }
}

class FinishedSession {
    const FinishedSession({
        required this.routineName,
        required this.totalSets,
        required this.volume,
        required this.duration,
    });

    final String routineName;
    final int totalSets;
    final double volume;
    final Duration duration;
}
