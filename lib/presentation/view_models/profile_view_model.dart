import 'package:flutter/material.dart';

import '../../domain/entities/profile.dart';
import '../state/profile_state.dart';

/// State for the profile editor screen. Delegates persistence to
/// [ProfileState] so all listeners (theme, home) refresh on save.
class ProfileViewModel {
    ProfileViewModel(this._current);

    Profile _current;
    bool _dirty = false;

    Profile get current => _current;

    void setName(String value) {
        _current = _current.copyWith(name: value);
        _dirty = true;
    }

    void toggleDay(int day) {
        final days = List<int>.from(_current.trainingDays);
        if (days.contains(day)) {
            if (days.length <= ProfileLimits.minTrainingDays) {
                return;
            }
            days.remove(day);
        } else {
            if (days.length >= ProfileLimits.maxTrainingDays) {
                return;
            }
            days.add(day);
            days.sort();
        }
        _current = _current.copyWith(trainingDays: days);
        _dirty = true;
    }

    void setThemeMode(ThemeMode mode) {
        if (_current.themeMode == mode) {
            return;
        }
        _current = _current.copyWith(themeModeIndex: mode.index);
        _dirty = true;
    }

    void setAmoled(bool value) {
        if (_current.amoled == value) {
            return;
        }
        _current = _current.copyWith(amoled: value);
        _dirty = true;
    }

    bool get isDirty => _dirty;

    Future<void> save() async {
        await ProfileState.save(_current);
        _dirty = false;
    }
}
