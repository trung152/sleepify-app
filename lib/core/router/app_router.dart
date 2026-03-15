import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/shell/presentation/screens/main_shell.dart';

import '../../features/onboarding/presentation/screens/bedtime_screen.dart';
import '../../features/onboarding/presentation/screens/goal_screen.dart';
import '../../features/onboarding/presentation/screens/language_screen.dart';
import '../../features/onboarding/presentation/screens/notification_screen.dart';
import '../../features/onboarding/presentation/screens/sleep_hours_screen.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';

/// Sleepify router configuration.
final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    // ── Splash ──────────────────────────────────────────────────────
    GoRoute(
      path: '/splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),

    // ── Onboarding ─────────────────────────────────────────────────
    GoRoute(
      path: '/onboarding/language',
      builder: (BuildContext context, GoRouterState state) {
        return const LanguageScreen();
      },
    ),
    GoRoute(
      path: '/onboarding/goal',
      builder: (BuildContext context, GoRouterState state) {
        return const GoalScreen();
      },
    ),
    GoRoute(
      path: '/onboarding/bedtime',
      builder: (BuildContext context, GoRouterState state) {
        return const BedtimeScreen();
      },
    ),
    GoRoute(
      path: '/onboarding/sleep-hours',
      builder: (BuildContext context, GoRouterState state) {
        return const SleepHoursScreen();
      },
    ),
    GoRoute(
      path: '/onboarding/notification',
      builder: (BuildContext context, GoRouterState state) {
        return const NotificationScreen();
      },
    ),

    // ── Main App (placeholder) ─────────────────────────────────────
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const MainShell();
      },
    ),
  ],
);
