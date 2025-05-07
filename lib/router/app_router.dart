import 'package:flutter/material.dart';
import 'package:flutter_practice/pages/add_expense_page.dart';
import 'package:flutter_practice/pages/add_income_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_practice/pages/counter_page.dart';
import 'package:flutter_practice/pages/income_expense_page.dart';
import 'package:flutter_practice/pages/settings_page.dart'; // Assuming a settings page might exist or be added
import 'package:flutter_practice/widgets/scaffold_with_nav_bar.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/counter',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ScaffoldWithNavBar(child: child),
      routes: [
        // Sub-routes for the shell
        GoRoute(
          path: '/counter',
          pageBuilder:
              (context, state) => const NoTransitionPage(child: CounterPage()),
        ),
        GoRoute(
          path: '/income-expense',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: IncomeExpensePage()),
          routes: [
            GoRoute(
              path: 'add-income', // Relative path
              // Use parentNavigatorKey to ensure it pushes onto the root navigator
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: AddIncomePage()),
            ),
            GoRoute(
              path: 'add-expense', // Relative path
              // Use parentNavigatorKey to ensure it pushes onto the root navigator
              parentNavigatorKey: _rootNavigatorKey,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: AddExpensePage()),
            ),
          ],
        ),
        GoRoute(
          path: '/settings',
          pageBuilder:
              (context, state) => const NoTransitionPage(child: SettingsPage()),
        ),
      ],
    ),
    // Example of a route outside the shell (e.g., a login page or a detail page)
    // GoRoute(
    //   path: '/login',
    //   builder: (context, state) => LoginPage(),
    // ),
  ],
  // Optional: Error page
  errorPageBuilder:
      (context, state) => MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(child: Text('Page not found: ${state.error?.message}')),
        ),
      ),
);
