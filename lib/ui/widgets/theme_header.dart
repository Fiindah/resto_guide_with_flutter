import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/theme_provider.dart';

class ThemeHeaderSwitch extends StatelessWidget {
  const ThemeHeaderSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    Color color(AppThemeMode mode) {
      return themeProvider.mode == mode
          ? Theme.of(context).colorScheme.primary
          : Colors.grey;
    }

    return Row(
      children: [
        IconButton(
          tooltip: 'Default Theme',
          icon: Icon(Icons.palette, color: color(AppThemeMode.softBlue)),
          onPressed: () => themeProvider.setTheme(AppThemeMode.softBlue),
        ),
        IconButton(
          tooltip: 'Light Theme',
          icon: Icon(Icons.light_mode, color: color(AppThemeMode.light)),
          onPressed: () => themeProvider.setTheme(AppThemeMode.light),
        ),
        IconButton(
          tooltip: 'Dark Theme',
          icon: Icon(Icons.dark_mode, color: color(AppThemeMode.dark)),
          onPressed: () => themeProvider.setTheme(AppThemeMode.dark),
        ),
      ],
    );
  }
}
