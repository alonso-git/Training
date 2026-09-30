import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:io' show exit;

import 'core/theme/app_theme.dart';
import 'core/utils/env_seed_flag.dart';
import 'data/services/backup_service.dart';
import 'data/services/database_factory.dart';
import 'data/services/database_service.dart';
import 'data/services/training_split_seed.dart';
import 'data/services/workout_service.dart';
import 'domain/entities/session.dart';
import 'presentation/screens/exercise_detail_screen.dart';
import 'presentation/screens/exercise_picker_screen.dart';
import 'presentation/screens/history_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/progress_screen.dart';
import 'presentation/screens/routine_edit_screen.dart';
import 'presentation/screens/routines_screen.dart';
import 'presentation/screens/session_screen.dart';
import 'presentation/screens/session_summary_screen.dart';
import 'presentation/view_models/session_view_model.dart';
import 'presentation/screens/settings_screen.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = await createDatabaseService();
    await bootstrapServices(database);
    if (seedSplitRequested) {
        await seedTrainingSplit(database);
        exit(0);
    }
    runApp(WorkoutApp(database: database));
}

/// Inserts the shared training split (6 routines, Mon/Wed/Fri).
Future<void> seedTrainingSplit(DatabaseService database) async {
    final workout = WorkoutService();
    await TrainingSplitSeed.seed(
        workout.exerciseExistsByName,
        workout.listExercises,
        workout.saveExercise,
        workout.saveRoutine,
    );
    await DataHub.refresh(AppServices.instance);
}

/// Opens the database and initializes the service locator.
Future<void> bootstrapServices(DatabaseService database) async {
    await AppServices.init(database);
    await DataHub.refresh(AppServices.instance);
}

class WorkoutApp extends StatelessWidget {
    WorkoutApp({required this.database, super.key});

    final DatabaseService database;

    late final GoRouter _router = GoRouter(
        routes: [
            GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
                routes: [
                    GoRoute(
                        path: 'session/:routineId',
                        builder: (context, state) => SessionScreen(
                            routineId: state.pathParameters['routineId']!,
                        ),
                    ),
                ],
            ),
            GoRoute(
                path: '/routines',
                builder: (context, state) => const RoutinesScreen(),
                routes: [
                    GoRoute(
                        path: ':routineId',
                        builder: (context, state) => RoutineEditScreen(
                            routineId: state.pathParameters['routineId']!,
                            isNew:
                                state.uri.queryParameters['new'] == '1',
                        ),
                    ),
                ],
            ),
            GoRoute(
                path: '/exercises/picker',
                builder: (context, state) => const ExercisePickerScreen(),
            ),
            GoRoute(
                path: '/history',
                builder: (context, state) => const HistoryScreen(),
                routes: [
                                    GoRoute(
                                        path: 'detail',
                                        builder: (context, state) =>
                                            SessionDetailScreen(
                                                session:
                                                    state.extra! as Session,
                                            ),
                                    ),
                ],
            ),
            GoRoute(
                path: '/progress',
                builder: (context, state) => const ProgressScreen(),
            ),
            GoRoute(
                path: '/exercises/detail/:exerciseId',
                builder: (context, state) => ExerciseDetailScreen(
                    exerciseId: state.pathParameters['exerciseId']!,
                    exerciseName:
                        state.uri.queryParameters['name'] ?? 'Exercise',
                ),
            ),
            GoRoute(
                path: '/summary',
                builder: (context, state) =>
                    SessionSummaryScreen(result: state.extra! as FinishedSession),
            ),
            GoRoute(
                path: '/settings',
                builder: (context, state) => SettingsScreen(
                    backup: BackupService(database),
                    database: database,
                ),
            ),
        ],
    );

    @override
    Widget build(BuildContext context) {
        return MaterialApp.router(
            title: 'Workout Tracker',
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: ThemeMode.system,
            routerConfig: _router,
        );
    }
}
