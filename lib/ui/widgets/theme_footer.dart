import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/theme_provider.dart';

class ThemeFooter extends StatelessWidget {
  const ThemeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    Color iconColor(AppThemeMode mode) {
      return themeProvider.mode == mode
          ? Theme.of(context).colorScheme.primary
          : Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: [
          const Text(
            '© 2026 Resto Guide',
            style: TextStyle(fontSize: 12),
          ),

          const Spacer(),
          IconButton(
            tooltip: 'Default Theme',
            icon: Icon(Icons.palette, color: iconColor(AppThemeMode.softBlue)),
            onPressed: () =>
                themeProvider.setTheme(AppThemeMode.softBlue),
          ),
          IconButton(
            tooltip: 'Light Theme',
            icon: Icon(Icons.light_mode,
                color: iconColor(AppThemeMode.light)),
            onPressed: () =>
                themeProvider.setTheme(AppThemeMode.light),
          ),
          IconButton(
            tooltip: 'Dark Theme',
            icon: Icon(Icons.dark_mode,
                color: iconColor(AppThemeMode.dark)),
            onPressed: () =>
                themeProvider.setTheme(AppThemeMode.dark),
          ),
        ],
      ),
    );
  }
}
