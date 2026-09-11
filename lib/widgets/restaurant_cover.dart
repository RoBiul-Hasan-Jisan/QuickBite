import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/restaurant.dart';
import '../theme/app_assets.dart';
import '../theme/app_theme.dart';

/// Renders a restaurant's cover photo when one is bundled, otherwise a
/// branded gradient with a large watermark icon — a deliberate, polished
/// fallback rather than a blank "no image" tile.
class RestaurantCover extends StatelessWidget {
  final Restaurant restaurant;
  final double? borderRadius;
  final Widget? overlay;

  const RestaurantCover({
    super.key,
    required this.restaurant,
    this.borderRadius,
    this.overlay,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? 0;
    final colors = AppPalette.gradientFor(restaurant.id + restaurant.name);

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (restaurant.coverImage != null)
            Image.asset(restaurant.coverImage!, fit: BoxFit.cover)
          else
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Opacity(
                    opacity: 0.25,
                    child: SvgPicture.asset(
                      AppAssets.cloche,
                      height: 72,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),
          // Subtle scrim so any overlaid text stays legible on photos too.
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Color(0x66000000)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          if (overlay != null) overlay!,
        ],
      ),
    );
  }
}
