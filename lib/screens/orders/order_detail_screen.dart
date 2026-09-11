import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/order.dart';
import '../../state/orders_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/dish_thumbnail.dart';

class OrderDetailScreen extends StatelessWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final ordersModel = OrdersScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Order details', style: TextStyle(fontWeight: FontWeight.w700))),
      body: AnimatedBuilder(
        animation: ordersModel,
        builder: (context, _) {
          final order = ordersModel.orders.firstWhere((o) => o.id == orderId);
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(order.restaurantName,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                        Text('#${order.id}',
                            style: const TextStyle(color: AppColors.textBody, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('MMM d, y · h:mm a').format(order.placedAt),
                      style: const TextStyle(color: AppColors.textBody, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const Text('Items', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              const SizedBox(height: AppSpacing.sm),
              ...order.lines.map(
                (line) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 52,
                        height: 52,
                        child: DishThumbnail(item: line.item, borderRadius: AppRadius.sm),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          '${line.quantity}× ${line.item.name}',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '\$${line.lineTotal.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(color: AppColors.border, height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total paid', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                  Text('\$${order.total.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              if (order.status == OrderStatus.delivered) ...[
                const Text('Rate this order', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                const SizedBox(height: AppSpacing.sm),
                _RatingRow(
                  rating: order.userRating ?? 0,
                  onRate: (value) => ordersModel.rateOrder(order.id, value),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onRate;

  const _RatingRow({required this.rating, required this.onRate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final filled = index < rating.round();
        return IconButton(
          onPressed: () => onRate((index + 1).toDouble()),
          icon: Icon(
            filled ? Icons.star_rounded : Icons.star_border_rounded,
            color: AppColors.star,
            size: 28,
          ),
        );
      }),
    );
  }
}
