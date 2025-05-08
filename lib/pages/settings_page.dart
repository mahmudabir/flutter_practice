import 'package:flutter/material.dart';
import 'package:flutter_practice/services/theme_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.go('/counter'); // Navigate to /counter
        }
      },
      child: Scaffold(
        // AppBar is handled by the ShellRoute's ScaffoldWithNavBar
        // appBar: AppBar(
        //   title: const Text('Settings'),
        // ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: const Text('Dark Mode'),
                trailing: Switch(
                  value: themeService.isDarkMode,
                  onChanged: (value) {
                    themeService.toggleTheme();
                  },
                ),
              ),
              // Add more settings options here
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      // AppBar is handled by the ShellRoute's ScaffoldWithNavBar
      // appBar: AppBar(
      //   title: const Text('Settings'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: themeService.isDarkMode,
                onChanged: (value) {
                  themeService.toggleTheme();
                },
              ),
            ),
            // Add more settings options here
          ],
        ),
      ),
    );
  }
}
