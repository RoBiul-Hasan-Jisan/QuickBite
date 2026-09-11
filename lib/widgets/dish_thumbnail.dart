import 'package:flutter/material.dart';

import '../models/food_item.dart';
import '../theme/app_theme.dart';

/// Renders a dish's photo when one is bundled, otherwise a tasteful
/// gradient tile with a category icon — avoids ever showing a blank
/// "no image" placeholder.
class DishThumbnail extends StatelessWidget {
  final FoodItem item;
  final double? borderRadius;

  const DishThumbnail({super.key, required this.item, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? 0;
    if (item.image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(item.image!, fit: BoxFit.cover),
      );
    }

    final colors = AppPalette.gradientFor(item.id + item.category);
    final icon = AppPalette.iconForCategory(item.category);

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              right: -10,
              bottom: -10,
              child: Icon(icon, size: 64, color: Colors.white.withOpacity(0.18)),
            ),
            Icon(icon, size: 32, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
