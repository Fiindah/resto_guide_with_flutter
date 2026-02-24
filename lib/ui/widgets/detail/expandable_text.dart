import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/expandable_provider.dart';

class ExpandableText extends StatelessWidget {
  final String text;
  final int maxLines;

  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 4,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExpandableTextProvider(),
      child: Consumer<ExpandableTextProvider>(
        builder: (context, provider, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                maxLines: provider.expanded ? null : maxLines,
                overflow: provider.expanded
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(height: 1.6),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () {
                  provider.toggle();
                },
                child: Text(
                  provider.expanded ? 'Read less' : 'Read more',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}