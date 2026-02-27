import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/local_database_provider.dart';
import 'package:resto_app/ui/widgets/resto_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  @override
  void initState() {
    Future.microtask(() {
      context.read<LocalDatabaseProvider>().loadAllRestaurant();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey("favorite_page"),
      appBar: AppBar(title: const Text("Favorite Restaurant")),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final list = value.restaurantList ?? [];

          if (list.isEmpty) {
            return const Center(
              child: Text("Belum ada restoran favorit"),
            );
          }

          return ListView.builder(
            key: const ValueKey("favorite_page"),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final restaurant = list[index];
              return RestaurantCard(restaurant: restaurant);
            },
          );
        },
      ),
    );
  }
}