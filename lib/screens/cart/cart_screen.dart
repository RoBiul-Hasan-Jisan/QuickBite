import 'package:flutter/material.dart';

import '../../models/food_item.dart';
import '../../state/cart_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/dish_thumbnail.dart';
import '../../widgets/primary_button.dart';
import '../checkout/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: AnimatedBuilder(
        animation: cart,
        builder: (context, _) {
          if (cart.lines.isEmpty) {
            return const _EmptyCart();
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: cart.lines.length,
                  separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final line = cart.lines[index];
                    return _CartLineTile(
                      line: line,
                      onIncrement: () =>
                          cart.updateQuantity(line.item.id, line.quantity + 1),
                      onDecrement: () =>
                          cart.updateQuantity(line.item.id, line.quantity - 1),
                      onRemove: () => cart.remove(line.item.id),
                    );
                  },
                ),
              ),
              _CheckoutSummary(cart: cart),
            ],
          );
        },
      ),
    );
  }
}

class _CartLineTile extends StatelessWidget {
  final CartLine line;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const _CartLineTile({
    required this.line,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: SizedBox(
              width: 72,
              height: 72,
              child: DishThumbnail(item: line.item, borderRadius: AppRadius.sm),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  line.item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${line.item.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _StepButton(icon: Icons.remove_rounded, onTap: onDecrement),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '${line.quantity}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    _StepButton(icon: Icons.add_rounded, onTap: onIncrement),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.delete_outline_rounded, color: AppColors.danger),
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _StepButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.scaffold,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, size: 14),
        ),
      ),
    );
  }
}

class _CheckoutSummary extends StatelessWidget {
  final CartModel cart;

  const _CheckoutSummary({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(color: Color(0x14000000), blurRadius: 20, offset: Offset(0, -6)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SummaryRow(label: 'Subtotal', value: cart.subtotal),
            const SizedBox(height: 6),
            _SummaryRow(label: 'Delivery fee', value: CartModel.deliveryFee),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(color: AppColors.border),
            ),
            _SummaryRow(label: 'Total', value: cart.total, bold: true),
            const SizedBox(height: AppSpacing.md),
            PrimaryButton(
              label: 'Checkout',
              icon: Icons.arrow_forward_rounded,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool bold;

  const _SummaryRow({required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: bold ? 16 : 14,
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

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.shopping_bag_outlined, size: 64, color: AppColors.textBody),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Your cart is empty',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            'Add some delicious meals to get started.',
            style: TextStyle(color: AppColors.textBody),
          ),
          const SizedBox(height: AppSpacing.lg),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Browse menu'),
          ),
        ],
      ),
    );
  }
}
