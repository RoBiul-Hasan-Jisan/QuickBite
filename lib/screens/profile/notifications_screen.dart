import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/empty_state.dart';

class _NotificationItem {
  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final String time;

  const _NotificationItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    required this.time,
  });
}

const _today = [
  _NotificationItem(
    icon: Icons.delivery_dining_rounded,
    color: AppColors.primary,
    title: 'Order delivered',
    message: 'Your order from Smokehouse Grill has been delivered. Enjoy!',
    time: '2h ago',
  ),
  _NotificationItem(
    icon: Icons.local_offer_rounded,
    color: AppColors.success,
    title: '20% off today only',
    message: 'Use code FUZZ20 on your next order before midnight.',
    time: '5h ago',
  ),
];

const _earlier = [
  _NotificationItem(
    icon: Icons.star_rounded,
    color: AppColors.star,
    title: 'Rate your last order',
    message: 'How was your Tonkotsu Ramen from Sakura Ramen House?',
    time: 'Yesterday',
  ),
  _NotificationItem(
    icon: Icons.card_giftcard_rounded,
    color: AppColors.primaryDark,
    title: 'Welcome to Fuzz App',
    message: 'Thanks for joining! Explore restaurants near you.',
    time: '3 days ago',
  ),
];

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: (_today.isEmpty && _earlier.isEmpty)
          ? const EmptyState(
              icon: Icons.notifications_none_rounded,
              title: 'No notifications',
              message: 'Order updates and offers will show up here.',
            )
          : ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                const Text('Today', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                const SizedBox(height: AppSpacing.sm),
                ..._today.map((n) => _Tile(item: n)),
                const SizedBox(height: AppSpacing.lg),
                const Text('Earlier', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                const SizedBox(height: AppSpacing.sm),
                ..._earlier.map((n) => _Tile(item: n)),
              ],
            ),
    );
  }
}

class _Tile extends StatelessWidget {
  final _NotificationItem item;

  const _Tile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(item.icon, size: 18, color: item.color),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                    Text(item.time, style: const TextStyle(color: AppColors.textBody, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(item.message, style: const TextStyle(color: AppColors.textBody, fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
