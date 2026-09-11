import 'package:flutter/material.dart';

import '../data/dummy_restaurants.dart';
import '../models/food_item.dart';
import '../state/cart_model.dart';
import '../theme/app_theme.dart';

/// Adds [item] to [cart], showing a confirmation dialog first if the cart
/// already has items from a *different* restaurant — most delivery apps
/// only let you order from one restaurant at a time.
Future<void> addToCartSafely(
  BuildContext context,
  CartModel cart,
  FoodItem item, {
  int quantity = 1,
}) async {
  if (cart.canAdd(item)) {
    cart.add(item, quantity: quantity);
    _showAddedSnack(context, item);
    return;
  }

  final currentRestaurant = restaurantById(cart.restaurantId!);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
      title: const Text('Start a new cart?'),
      content: Text(
        'Your cart has items from ${currentRestaurant.name}. Adding from a different '
        'restaurant will clear your current cart.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Start new cart'),
        ),
      ],
    ),
  );

  if (confirmed == true) {
    cart.clear();
    cart.add(item, quantity: quantity);
    if (context.mounted) _showAddedSnack(context, item);
  }
}

void _showAddedSnack(BuildContext context, FoodItem item) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 900),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.dark,
      content: Text('${item.name} added to cart'),
    ),
  );
}
