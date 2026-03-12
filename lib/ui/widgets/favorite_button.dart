import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/model/resto_detail_response.dart';
import 'package:resto_app/provider/local_database_provider.dart';

class FavoriteButton extends StatelessWidget {
  final RestaurantDetail restaurant;

  const FavoriteButton({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<LocalDatabaseProvider>();
    final providerRead = context.read<LocalDatabaseProvider>();

    final isFavorite = providerWatch.checkItemFavorite(restaurant.id);

    return AnimatedScale(
      scale: isFavorite ? 1.1 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.2)),
          ],
        ),
        child: IconButton(
          key: const ValueKey("favorite_button"),
          onPressed: () async {
            if (!isFavorite) {
              await providerRead.saveRestaurant(restaurant.toRestaurant());
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Restoran ditambahkan ke favorit"),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            } else {
              await providerRead.removeRestaurantById(restaurant.id);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Restoran dihapus dari favorit"),
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            }
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              key: ValueKey(isFavorite),
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
