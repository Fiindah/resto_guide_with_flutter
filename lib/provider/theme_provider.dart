import 'package:flutter/material.dart';

enum AppThemeMode { system, light, dark, softBlue }

class ThemeProvider extends ChangeNotifier {
  AppThemeMode _mode = AppThemeMode.system;

  AppThemeMode get mode => _mode;

  ThemeMode get themeMode {
    switch (_mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
      case AppThemeMode.softBlue:
        return ThemeMode.light;
    }
  }

  void setTheme(AppThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }
}
