import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/data/model/resto_detail_response.dart';
import '../../../../provider/favorite_provider.dart';

class FavoriteButton extends StatefulWidget {
  final RestaurantDetail restaurant;

  const FavoriteButton({super.key, required this.restaurant});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<FavoriteProvider>().checkFavorite(widget.restaurant.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, provider, _) {
        final isFavorite = provider.isFavorite;

        return Positioned(
          top: 40,
          right: 16,
          child: FloatingActionButton(
            mini: true,
            elevation: 4,
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: () async {
              if (isFavorite) {
                await provider.removeFavorite(widget.restaurant.id);
              } else {
                await provider.addFavorite(
                  id: widget.restaurant.id,
                  name: widget.restaurant.name,
                  city: widget.restaurant.city,
                  pictureId: widget.restaurant.pictureId,
                  rating: widget.restaurant.rating,
                  description: widget.restaurant.description,
                );
              }
            },
            child: Icon(
              key: const Key('favorite_button'),
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
