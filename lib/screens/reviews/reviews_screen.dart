import 'package:flutter/material.dart';

import '../../data/dummy_reviews.dart';
import '../../data/dummy_restaurants.dart';
import '../../theme/app_theme.dart';
import '../../widgets/review_card.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reviews = reviewsForRestaurant(kRestaurant.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(AppSpacing.lg),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.4),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Row(
              children: [
                const Icon(Icons.star_rounded, color: AppColors.star, size: 32),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  kRestaurant.rating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'based on ${kRestaurant.reviewCount} reviews',
                  style: const TextStyle(color: AppColors.textBody, fontSize: 13),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.xl),
              itemCount: reviews.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) => ReviewCard(review: reviews[index]),
            ),
          ),
        ],
      ),
    );
  }
}
