import 'package:flutter/material.dart';

import '../../data/dummy_restaurants.dart';
import '../../models/order.dart';
import '../../state/addresses_model.dart';
import '../../state/cart_model.dart';
import '../../state/orders_model.dart';
import '../../state/payment_methods_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/primary_button.dart';
import '../profile/addresses_screen.dart';
import '../profile/payment_methods_screen.dart';
import '../tracking/order_tracking_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final addresses = AddressesScope.of(context);
    final payments = PaymentMethodsScope.of(context);
    final orders = OrdersScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.w700))),
      body: AnimatedBuilder(
        animation: Listenable.merge([cart, addresses, payments]),
        builder: (context, _) {
          final address = addresses.selected;
          final card = payments.selected;

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              const Text('Deliver to', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              const SizedBox(height: AppSpacing.sm),
              _SelectionTile(
                icon: Icons.location_on_rounded,
                title: address.label,
                subtitle: '${address.line1}, ${address.line2}',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AddressesScreen(selectionMode: true)),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Text('Pay with', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              const SizedBox(height: AppSpacing.sm),
              _SelectionTile(
                icon: Icons.credit_card_rounded,
                title: '${card.brandLabel} •••• ${card.last4}',
                subtitle: card.holderName,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PaymentMethodsScreen(selectionMode: true)),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Text('Order summary', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    ...cart.lines.map(
                      (line) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Text('${line.quantity}×', style: const TextStyle(color: AppColors.textBody, fontSize: 13)),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(line.item.name,
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                            ),
                            Text('\$${line.lineTotal.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: AppColors.border),
                    _SummaryLine(label: 'Subtotal', value: cart.subtotal),
                    const SizedBox(height: 4),
                    _SummaryLine(label: 'Delivery fee', value: CartModel.deliveryFee),
                    const SizedBox(height: 8),
                    _SummaryLine(label: 'Total', value: cart.total, bold: true),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.md),
          child: PrimaryButton(
            label: 'Place order · \$${cart.total.toStringAsFixed(2)}',
            icon: Icons.check_circle_outline_rounded,
            onPressed: cart.lines.isEmpty
                ? null
                : () {
                    final firstItemRestaurantId = cart.lines.first.item.restaurantId;
                    final restaurant = restaurantById(firstItemRestaurantId);
                    final order = OrderRecord(
                      id: 'ord${DateTime.now().millisecondsSinceEpoch}',
                      restaurantId: firstItemRestaurantId,
                      restaurantName: restaurant.name,
                      restaurantImage: restaurant.coverImage,
                      lines: List.of(cart.lines),
                      total: cart.total,
                      placedAt: DateTime.now(),
                      status: OrderStatus.onTheWay,
                    );
                    orders.addOrder(order);
                    cart.clear();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => OrderTrackingScreen(orderId: order.id)),
                    );
                  },
          ),
        ),
      ),
    );
  }

}

class _SelectionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SelectionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.textBody, fontSize: 12)),
                ],
              ),
            ),
            const Text('Change',
                style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.w600, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  final String label;
  final double value;
  final bool bold;

  const _SummaryLine({required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: bold ? 15 : 13,
      fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
      color: bold ? AppColors.dark : AppColors.textBody,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text('\$${value.toStringAsFixed(2)}', style: style),
      ],
    );
  }
}
