import 'package:flutter/material.dart';

class AppTheme {
  static const _fontFamily = 'Poppins';

  static TextTheme _customTextTheme(Brightness brightness) {
    final base = ThemeData(brightness: brightness).textTheme;

    return base.copyWith(
      headlineMedium: base.headlineMedium?.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: base.bodyMedium?.copyWith(fontSize: 14, height: 1.6),
      labelLarge: base.labelLarge?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    );
  }

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: _fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.light,
    ),
    textTheme: _customTextTheme(Brightness.light),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: _fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.dark,
    ),
    textTheme: _customTextTheme(Brightness.dark),
    useMaterial3: true,
  );

  static ThemeData softBlueTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: _fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF9CCFFF),
      brightness: Brightness.light,
    ),
    textTheme: _customTextTheme(Brightness.light),
    scaffoldBackgroundColor: const Color(0xFFF1F5FF),
    cardColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF9CCFFF),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    useMaterial3: true,
  );
}
