import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/api/resto_api_service.dart';
import 'package:resto_app/provider/resto_list_provider.dart';
import 'package:resto_app/provider/search_provider.dart';
import 'package:resto_app/provider/theme_provider.dart';
import 'package:resto_app/theme/app_theme.dart';
import 'package:resto_app/ui/pages/home_page.dart';
import 'package:resto_app/ui/pages/search_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => RestaurantApiService(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            apiService: context.read<RestaurantApiService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(
            apiService: context.read<RestaurantApiService>(),
          ),
        ),

        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resto Guide',
      theme: themeProvider.mode == AppThemeMode.softBlue
          ? AppTheme.softBlueTheme
          : AppTheme.lightTheme,

      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,

      routes: {
        '/': (context) => const HomePage(),
        '/search': (context) => const SearchPage(),
      },
    );
  }
}
