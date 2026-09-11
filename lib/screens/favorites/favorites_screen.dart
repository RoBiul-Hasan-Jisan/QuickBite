import 'package:flutter/material.dart';

import '../../data/dummy_restaurants.dart';
import '../../state/cart_model.dart';
import '../../state/favorites_model.dart';
import '../../theme/app_theme.dart';
import '../../utils/cart_helpers.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/food_card.dart';
import '../food_detail/food_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesScope.of(context);
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([favorites, cart]),
        builder: (context, _) {
          final favDishes = kMenuItems.where((f) => favorites.isDishFavorite(f.id)).toList();

          if (favDishes.isEmpty) {
            return const EmptyState(
              icon: Icons.favorite_border_rounded,
              title: 'No favorites yet',
              message: 'Tap the heart icon on a dish to save it here.',
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(AppSpacing.lg),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 0.68,
            ),
            itemCount: favDishes.length,
            itemBuilder: (context, index) {
              final item = favDishes[index];
              return FoodCard(
                item: item,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => FoodDetailScreen(item: item)),
                ),
                onAdd: () => addToCartSafely(context, cart, item),
              );
            },
          );
        },
      ),
    );
  }
}
