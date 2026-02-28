import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/local_database_provider.dart';
import 'package:resto_app/ui/widgets/resto_card.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey("favorite_page"),
      appBar: AppBar(title: const Text("Favorite Restaurant")),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, provider, child) {
          final list = provider.restaurantList ?? [];

          if (list.isEmpty) {
            return const Center(
              child: Text("Belum ada restoran favorit"),
            );
          }

          return ListView.builder(
            key: const ValueKey("favorite_list"),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return RestaurantCard(
                restaurant: list[index],
              );
            },
          );
        },
      ),
    );
  }
}