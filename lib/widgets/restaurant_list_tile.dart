import 'package:flutter/material.dart';

import '../models/restaurant.dart';
import '../theme/app_theme.dart';
import 'restaurant_cover.dart';

class RestaurantListTile extends StatelessWidget {
  final Restaurant restaurant;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const RestaurantListTile({
    super.key,
    required this.restaurant,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: [
            BoxShadow(
              color: AppColors.dark.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: RestaurantCover(
                restaurant: restaurant,
                borderRadius: AppRadius.lg,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            restaurant.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                        ),
                        GestureDetector(
                          onTap: onFavoriteToggle,
                          child: Icon(
                            isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            size: 20,
                            color: isFavorite ? AppColors.danger : AppColors.textBody,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      restaurant.tagline,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.textBody, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, size: 14, color: AppColors.star),
                        const SizedBox(width: 2),
                        Text(
                          '${restaurant.rating} (${restaurant.reviewCount})',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.timer_outlined, size: 13, color: AppColors.textBody),
                        const SizedBox(width: 2),
                        Text(
                          '${restaurant.deliveryTimeMinutes} min',
                          style: const TextStyle(fontSize: 12, color: AppColors.textBody),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${restaurant.deliveryFeeLabel} · ${restaurant.distanceKm} km',
                      style: const TextStyle(fontSize: 12, color: AppColors.textBody),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
