import 'package:flutter/material.dart';
import 'package:resto_app/data/model/resto_detail_response.dart';

class DetailHeader extends StatelessWidget {
  final RestaurantDetail restaurant;

  const DetailHeader({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          clipBehavior: Clip.none,
          children: [
            Hero(
              tag: restaurant.id,
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            ],
        ),
      ),
    );
  }
}
