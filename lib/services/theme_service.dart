import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModePreference { system, light, dark }

class ThemeService with ChangeNotifier {
  static const String _themePreferenceKey = 'theme_preference';

  ThemeModePreference _themeModePreference = ThemeModePreference.system;
  ThemeMode _themeMode = ThemeMode.system;

  ThemeService() {
    _loadThemePreference();
  }

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  ThemeModePreference get themeModePreference => _themeModePreference;

  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final preferenceIndex =
        prefs.getInt(_themePreferenceKey) ?? ThemeModePreference.system.index;
    _themeModePreference = ThemeModePreference.values[preferenceIndex];
    _setThemeModeFromPreference();
    notifyListeners();
  }

  Future<void> setThemeModePreference(ThemeModePreference preference) async {
    _themeModePreference = preference;
    _setThemeModeFromPreference();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themePreferenceKey, preference.index);
    notifyListeners();
  }

  void _setThemeModeFromPreference() {
    switch (_themeModePreference) {
      case ThemeModePreference.light:
        _themeMode = ThemeMode.light;
        break;
      case ThemeModePreference.dark:
        _themeMode = ThemeMode.dark;
        break;
      case ThemeModePreference.system:
      default:
        _themeMode = ThemeMode.system;
        break;
    }
  }

  void toggleTheme() {
    if (_themeModePreference == ThemeModePreference.light) {
      setThemeModePreference(ThemeModePreference.dark);
    } else if (_themeModePreference == ThemeModePreference.dark) {
      setThemeModePreference(ThemeModePreference.light);
    } else {
      // If system, default to toggling to dark, or light if already dark in system
      // This part might need more sophisticated logic based on current system theme
      // For simplicity, we'll toggle between light and dark directly
      final Brightness platformBrightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      if (platformBrightness == Brightness.dark) {
        setThemeModePreference(ThemeModePreference.light);
      } else {
        setThemeModePreference(ThemeModePreference.dark);
      }
    }
  }
}
