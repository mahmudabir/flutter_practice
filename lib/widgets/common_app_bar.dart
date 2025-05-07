import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_practice/services/theme_service.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CommonAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
