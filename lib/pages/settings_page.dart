import 'package:flutter/material.dart';
import 'package:flutter_practice/services/theme_service.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

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
