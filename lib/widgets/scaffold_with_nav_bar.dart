import 'package:flutter/material.dart';
import 'package:flutter_practice/widgets/app_drawer.dart';
import 'package:go_router/go_router.dart';

import 'common_app_bar.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  final Widget child;

  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  int _currentIndex = 0;

  // Helper method to determine the current index based on the route
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/counter')) {
      return 0;
    }
    if (location.startsWith('/income-expense')) {
      return 1;
    }
    if (location.startsWith('/settings')) {
      return 2;
    }
    return 0; // Default to the first item
  }

  void _onItemTapped(int index, BuildContext context) {
    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        context.push('/counter');
        break;
      case 1:
        context.push('/income-expense');
        break;
      case 2:
        context.push('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update the current index when the widget builds or route changes
    _currentIndex = _calculateSelectedIndex(context);

    return Scaffold(
      // AppBar can be customized here or within individual pages if needed
      // For a truly persistent AppBar title that changes with routes,
      // you might need to manage title state here based on the current route.
      appBar: CommonAppBar(title: _getAppBarTitle(GoRouterState.of(context).uri.toString())),
      // Drawer can be added here if it's part of the shell
      drawer: const AppDrawer(),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Counter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Income/Expense',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }

  String _getAppBarTitle(String location) {
    if (location.startsWith('/income-expense/add-income')) {
      return 'Add Income';
    }
    if (location.startsWith('/income-expense/add-expense')) {
      return 'Add Expense';
    }
    if (location == '/counter') {
      return 'Counter';
    }
    if (location.startsWith('/income-expense')) {
      return 'Income & Expense Tracker';
    }
    if (location.startsWith('/settings')) {
      return 'Settings';
    }
    return 'Flutter Practice'; // Default title
  }
}
