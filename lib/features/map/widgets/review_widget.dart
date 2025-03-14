import 'package:flutter/material.dart';
import 'package:onegid/features/map/map.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key, required this.review});
  final Review review;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: theme.colorScheme.secondary)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(review.author, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          Text(review.text, style: theme.textTheme.titleMedium)
        ],
      )
    );
  }
}