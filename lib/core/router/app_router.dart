import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Sleepify router configuration.
///
/// Placeholder routes — features will register their own routes here.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        // TODO: Replace with HomeScreen or OnboardingScreen
        return const Scaffold(
          body: Center(child: Text('Sleepify')),
        );
      },
    ),
  ],
);
