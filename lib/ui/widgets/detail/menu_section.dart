import 'package:flutter/material.dart';

class MenuSection extends StatelessWidget {
  final List<dynamic> foods;
  final List<dynamic> drinks;

  const MenuSection({super.key, required this.foods, required this.drinks});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Text(
            'Foods',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buildChips(context, foods),
          const SizedBox(height: 16),
          const Text(
            'Drinks',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buildChips(context, drinks),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildChips(BuildContext context, List<dynamic> items) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: items.map((item) {
        return Chip(label: Text(item.name));
      }).toList(),
    );
  }
}
