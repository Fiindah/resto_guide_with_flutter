import 'package:flutter/material.dart';
import 'package:resto_app/data/model/resto_detail_response.dart';

class DetailHeader extends StatelessWidget {
  final RestaurantDetail restaurant;
  final String source;

  const DetailHeader({
    super.key,
    required this.restaurant,
    this.source = 'home',
  });

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
              tag: '${source}_${restaurant.id}',
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
