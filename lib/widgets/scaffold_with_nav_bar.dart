import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_practice/widgets/app_drawer.dart'; // Import AppDrawer
import 'package:provider/provider.dart';
import 'package:flutter_practice/services/theme_service.dart';

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
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        context.go('/counter');
        break;
      case 1:
        context.go('/income-expense');
        break;
      case 2:
        context.go('/settings');
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
      appBar: AppBar(
        title: Text(_getAppBarTitle(GoRouterState.of(context).uri.toString())),
        actions: [
          Consumer<ThemeService>(
            builder: (context, themeService, child) {
              return IconButton(
                icon: Icon(
                  themeService.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                tooltip:
                    themeService.isDarkMode
                        ? 'Switch to Light Mode'
                        : 'Switch to Dark Mode',
                onPressed: () {
                  themeService.toggleTheme();
                },
              );
            },
          ),
        ],
        // You might want to add a back button conditionally for web/desktop
        // leading: GoRouter.of(context).canPop() ? BackButton() : null,
      ),
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
      // Drawer can be added here if it's part of the shell
      drawer: const AppDrawer(),
    );
  }

  String _getAppBarTitle(String location) {
    if (location.startsWith('/counter')) {
      return 'Counter Page';
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
