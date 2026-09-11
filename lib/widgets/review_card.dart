import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/restaurant.dart';
import '../theme/app_theme.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final initials = review.userName.trim().isEmpty
        ? '?'
        : review.userName.trim()[0].toUpperCase();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryLight,
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                    Text(
                      DateFormat.yMMMd().format(review.date),
                      style: const TextStyle(color: AppColors.textBody, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star_rounded, size: 15, color: AppColors.star),
                  const SizedBox(width: 2),
                  Text(
                    review.rating.toStringAsFixed(1),
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            review.comment,
            style: const TextStyle(color: AppColors.textBody, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              const Icon(Icons.thumb_up_alt_outlined, size: 14, color: AppColors.textBody),
              const SizedBox(width: 4),
              Text(
                'Helpful (${review.helpfulCount})',
                style: const TextStyle(color: AppColors.textBody, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
