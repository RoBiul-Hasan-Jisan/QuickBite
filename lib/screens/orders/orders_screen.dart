import 'package:flutter/material.dart';

import '../../state/cart_model.dart';
import '../../state/orders_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/order_card.dart';
import 'order_detail_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ordersModel = OrdersScope.of(context);
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: AnimatedBuilder(
        animation: ordersModel,
        builder: (context, _) {
          final orders = ordersModel.orders;
          if (orders.isEmpty) {
            return const EmptyState(
              icon: Icons.receipt_long_outlined,
              title: 'No orders yet',
              message: 'Your order history will show up here once you place one.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final order = orders[index];
              return OrderCard(
                order: order,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => OrderDetailScreen(orderId: order.id)),
                ),
                onReorder: () {
                  for (final line in order.lines) {
                    cart.add(line.item, quantity: line.quantity);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(milliseconds: 1200),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: AppColors.dark,
                      content: Text('${order.restaurantName} order added to cart'),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
