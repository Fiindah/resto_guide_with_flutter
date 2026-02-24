import 'package:flutter/material.dart';
import 'package:resto_app/data/model/resto_detail_response.dart';
import './expandable_text.dart';

class DetailInfoSection extends StatelessWidget {
  final RestaurantDetail restaurant;

  const DetailInfoSection({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            key: const Key('detail_title'),
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 4),
              Text(restaurant.rating.toString()),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.location_on, size: 18),
              const SizedBox(width: 4),
              Expanded(
                child: Text('${restaurant.address}, ${restaurant.city}'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'About',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ExpandableText(text: restaurant.description),
        ],
      ),
    );
  }
}
