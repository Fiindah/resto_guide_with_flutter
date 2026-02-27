import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/navigation_provider.dart';
import 'home_page.dart';
import 'favorite_page.dart';
import 'setting_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Consumer<NavigationProvider>(
      builder: (context, navProvider, _) {
        final pages = const [
          HomePage(),
          FavoritePage(),
          SettingPage(),
        ];

        return Scaffold(
          body: IndexedStack(
            index: navProvider.selectedIndex,
            children: pages,
          ),
          bottomNavigationBar: NavigationBar(
            key: const ValueKey("bottom_nav"),
            selectedIndex: navProvider.selectedIndex,
            onDestinationSelected: (index) {
              navProvider.changeIndex(index);
            },
            backgroundColor: scheme.surface,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                key: const ValueKey("bottom_nav_favorite"),
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Setting',
              ),
            ],
          ),
        );
      },
    );
  }
}