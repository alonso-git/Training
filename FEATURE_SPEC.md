# Workout Routine Tracker Specification

## 1. High-Level Objective
A personal workout companion app for fitness enthusiasts to track their training routines and weight progression. The app helps users remember their workout schedules, log exercises with weights and reps, and provides intelligent weight increase suggestions based on performance. Target users are individuals (developer + girlfriend) who want a simple, local-first tool to avoid memorizing routines and track strength gains over time.

## 2. Requirements
**Functional:**
- Create, edit, and delete multiple workout routines (e.g., "Push day", "Leg day")
- Assign each routine to specific days of the week (e.g., Mon/Wed/Fri = Push day)
- Access a predefined catalog of common exercises plus create custom exercises
- Each exercise includes: name, muscle group, number of sets, target rep range (min/max), and weight increment value
- Start a workout session from the day's assigned routine
- During a session: display exercises one at a time, set weight once per exercise, log reps for each set
- Auto-fill weight from the last session for that exercise (user can override)
- Suggest weight increase for the next week if the user achieved max recommended reps in any session this week
- Weight increment is muscle-group-based: upper body push/pull = 2.5kg, legs = 5kg, isolation/small muscles = 1.25kg
- User can override rep ranges and weight increments per exercise
- View session history as a list (date, routine, exercises completed)
- View progress charts: weight progression per exercise over time, total volume trends (sets × reps × weight)
- Export all data as JSON for backup
- Import data from JSON file to restore

## 3. Technical rules
**Architecture:**
- MVVM pattern with services layer
- Domain layer: entities (Routine, Exercise, Session, Set)
- Data layer: repositories with Isar implementation (abstract interface for future API migration)
- Presentation layer: screens with flutter_signals for reactive state

**Technologies:**
- Flutter 3.35.3 (stable channel)
- State management: flutter_signals package (signal, computed, effect)
- Local storage: Isar (NoSQL database with queries and relationships)
- UI: Material Design 3 components, system theme (light/dark mode)
- Charts: fl_chart package for progress visualization
- Single user per device (no authentication required)

**File Structure:**
```
lib/
├── domain/
│   ├── entities/          # Routine, Exercise, Session, Set, ExerciseLog, SetLog
│   └── repositories/      # Abstract repository interfaces
├── data/
│   ├── models/            # Isar collection schemas
│   ├── repositories/      # Isar repository implementations
│   └── services/          # Data access services
├── presentation/
│   ├── screens/           # Home, RoutineDetail, Session, History, Progress, Settings
│   ├── widgets/           # Reusable UI components
│   └── view_models/       # Screen-specific state and logic
├── core/
│   ├── constants/         # App-wide constants (muscle groups, default increments)
│   ├── utils/             # Helper functions (date formatting, JSON export/import)
│   └── theme/             # Material 3 theme configuration
└── main.dart
```

**Good Practices:**
- Repository pattern: all data access goes through repository interfaces, making it easy to swap Isar for API calls later
- Immutable entities in domain layer
- Reactive state with flutter_signals (avoid setState where possible)
- Type-safe queries with Isar
- Separation of concerns: UI only handles display, ViewModels handle logic, Services handle data

## 4. Business rules
**Data Validation:**
- Routine name: required, 1-50 characters
- Exercise name: required, 1-100 characters
- Sets: integer, 1-20
- Rep range: min 1-50, max 1-100, max >= min
- Weight: decimal, 0-1000 kg, increments of 0.25kg
- Weight increment: decimal, 0.25-50 kg

**Data Storage:**
- All data stored locally in Isar database
- No cloud sync or multi-user support (single user per device)
- Export creates a JSON file with all routines, exercises, sessions, and logs
- Import replaces all existing data (with confirmation dialog)

**Access Control:**
- No authentication or user accounts
- All data accessible within the app (no per-resource permissions)

**Weight Suggestion Logic:**
- Track the maximum reps achieved for each exercise in each session
- If max reps >= exercise's target max reps in any session this week, suggest weight increase for next week
- Suggestion appears at the start of the next session for that exercise
- Increment amount depends on muscle group:
  - Upper body push (chest, shoulders, triceps): 2.5kg
  - Upper body pull (back, biceps): 2.5kg
  - Legs (quads, hamstrings, glutes, calves): 5kg
  - Isolation/small muscles (abs, forearms, neck): 1.25kg
- User can manually override the suggested weight

## 5. Implementation Logic (The "How")

**Step 1: Project Setup & Data Models**
- Initialize Flutter project with required dependencies (isar, flutter_signals, fl_chart)
- Define domain entities: Routine, Exercise, Session, ExerciseLog, SetLog
- Create Isar collection schemas matching entities
- Implement repository interfaces and Isar implementations
- Create seed data: predefined exercise catalog (bench press, squat, deadlift, etc.)

**Step 2: Routine Management**
- Build home screen showing today's assigned routine (if any)
- Create routine list screen (view all routines)
- Build routine detail/edit screen (name, day-of-week assignment, exercise list)
- Implement exercise picker (predefined catalog + custom option)
- Add exercise configuration (sets, rep range, weight increment, muscle group)

**Step 3: Session Flow**
- Build session start screen (shows routine, first exercise)
- Implement exercise-by-exercise flow:
  - Display exercise name, target sets/reps
  - Auto-fill weight from last session (show suggestion if applicable)
  - User logs reps for each set
  - Move to next exercise
- Session completion screen (summary: total sets, volume, duration)
- Save session to database

**Step 4: History & Progress**
- Build session history list (sorted by date, show routine name, date, key stats)
- Create exercise detail screen (shows all sessions for that exercise)
- Implement progress charts:
  - Line chart: weight progression per exercise over time
  - Bar chart: total volume per session
  - Frequency chart: sessions per week/month

**Step 5: Settings & Export/Import**
- Build settings screen (export/import options)
- Implement JSON export (serialize all data to file)
- Implement JSON import (parse file, replace database, show confirmation)
- Add app info (version, data size)

**Data Contracts:**

Routine:
```json
{
  "id": "uuid",
  "name": "Push Day",
  "dayOfWeek": 1,  // 0=Sunday, 1=Monday, etc.
  "exerciseIds": ["uuid1", "uuid2", "uuid3"]
}
```

Exercise:
```json
{
  "id": "uuid",
  "name": "Bench Press",
  "muscleGroup": "chest",
  "sets": 4,
  "minReps": 8,
  "maxReps": 12,
  "weightIncrement": 2.5,
  "isCustom": false
}
```

Session:
```json
{
  "id": "uuid",
  "routineId": "uuid",
  "date": "2026-09-24T18:30:00Z",
  "exerciseLogs": [
    {
      "exerciseId": "uuid",
      "weight": 60.0,
      "sets": [
        {"reps": 10},
        {"reps": 10},
        {"reps": 9},
        {"reps": 8}
      ]
    }
  ]
}
```

## 6. Acceptance Criteria (The "Tests")

**Happy Path:**
1. User opens app → sees today's routine (if assigned) or "No routine today"
2. User taps "Start Workout" → session begins with first exercise
3. Weight auto-fills from last session (or starts at 0 if first time)
4. User logs reps for each set → taps "Next Set" → completes all sets
5. User moves to next exercise → repeats until routine complete
6. User taps "Finish Workout" → session saved, returns to home
7. User navigates to "History" → sees list of past sessions
8. User taps a past session → sees detailed breakdown (exercises, weights, reps)
9. User navigates to "Progress" → sees charts for weight progression and volume
10. User navigates to "Settings" → taps "Export Data" → JSON file created
11. User taps "Import Data" → selects file → data restored (with confirmation)

**Edge Cases:**
- If no routine assigned to today → show "No routine today" with option to start any routine manually
- If exercise has no previous session → weight starts at 0, no suggestion
- If user hits max reps this week → next session shows "Suggested weight: X kg" (user can override)
- If import file is invalid JSON → show error message, don't modify database
- If user tries to import while data exists → show confirmation dialog ("This will replace all existing data")
- If all sets are incomplete (0 reps) → don't save session, show warning

**Validation:**
1. Create a routine with 3 exercises → verify it appears in routine list and is assigned to correct day
2. Start a session → verify weight auto-fills from last session (or 0 if first time)
3. Log reps for all sets → verify session appears in history with correct data
4. Hit max reps (12) on bench press → start session next week → verify weight suggestion appears (60kg → 62.5kg)
5. Override suggested weight → verify custom weight is used and logged
6. Export data → verify JSON file contains all routines, exercises, sessions
7. Import data → verify all data restored correctly, old data replaced
8. Check progress charts → verify weight progression line chart shows correct data points over time
9. Run `flutter test` → all unit tests pass (repositories, view models, services)
10. Run `flutter analyze` → no warnings or errors
