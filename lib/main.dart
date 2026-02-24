import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/api/resto_api_service.dart';
import 'package:resto_app/provider/favorite_provider.dart';
import 'package:resto_app/provider/resto_list_provider.dart';
import 'package:resto_app/provider/search_provider.dart';
import 'package:resto_app/provider/theme_provider.dart';
import 'package:resto_app/provider/reminder_provider.dart';
import 'package:resto_app/services/notification_helper.dart';
import 'package:resto_app/services/notification_service.dart';
import 'package:resto_app/theme/app_theme.dart';
import 'package:resto_app/ui/pages/main-page.dart';
import 'package:resto_app/ui/pages/search_page.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // init plugin di background isolate
    await NotificationHelper.init();

    if (task == "dailyReminderTask") {
      await NotificationHelper.showRandomRestaurantNotification();
    }

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final notificationService = NotificationService();
  await notificationService.init();

  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => RestaurantApiService()),
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            apiService: context.read<RestaurantApiService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              SearchProvider(apiService: context.read<RestaurantApiService>()),
        ),

        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(
          create: (_) => ReminderProvider()..loadReminder(),
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
      theme: themeProvider.isSoftBlue
          ? AppTheme.softBlueTheme
          : AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,

      routes: {
        '/': (context) => const MainPage(),
        '/search': (context) => const SearchPage(),
      },
    );
  }
}
