import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme _customTextTheme(Brightness brightness) {
  final base = ThemeData(brightness: brightness).textTheme;

  final poppins = GoogleFonts.poppinsTextTheme(base);

  return poppins.copyWith(
    headlineMedium: poppins.headlineMedium?.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
    titleMedium: poppins.titleMedium?.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: poppins.bodyMedium?.copyWith(
      fontSize: 14,
      height: 1.6,
    ),
    labelLarge: poppins.labelLarge?.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3,
    ),
  );
}

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.light,
    ),
    textTheme: _customTextTheme(Brightness.light),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.dark,
    ),
    textTheme: _customTextTheme(Brightness.dark),
    useMaterial3: true,
  );

  static ThemeData softBlueTheme = ThemeData(
    brightness: Brightness.light,
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
