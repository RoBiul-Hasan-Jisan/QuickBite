import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../state/cart_model.dart';
import '../../theme/app_assets.dart';
import '../../theme/app_theme.dart';
import '../../widgets/primary_button.dart';
import '../home/home_screen.dart';

enum OrderStage { confirmed, preparing, onTheWay, delivered }

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  OrderStage _stage = OrderStage.confirmed;

  static const _stageLabels = {
    OrderStage.confirmed: 'Order confirmed',
    OrderStage.preparing: 'Preparing your food',
    OrderStage.onTheWay: 'Rider on the way',
    OrderStage.delivered: 'Delivered',
  };

  static const _stageIcons = {
    OrderStage.confirmed: Icons.receipt_long_rounded,
    OrderStage.preparing: Icons.soup_kitchen_outlined,
    OrderStage.onTheWay: Icons.delivery_dining_rounded,
    OrderStage.delivered: Icons.home_rounded,
  };

  @override
  void initState() {
    super.initState();
    _advance();
  }

  void _advance() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final nextIndex = _stage.index + 1;
      if (nextIndex < OrderStage.values.length) {
        setState(() => _stage = OrderStage.values[nextIndex]);
        _advance();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDelivered = _stage == OrderStage.delivered;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track order', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: Column(
        children: [
          Expanded(
            child: _MapMock(stage: _stage),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.md),
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
              boxShadow: [
                BoxShadow(color: Color(0x14000000), blurRadius: 24, offset: Offset(0, -8)),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _stageLabels[_stage]!,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isDelivered
                        ? 'Enjoy your meal!'
                        : 'Estimated arrival in 18–25 minutes',
                    style: const TextStyle(color: AppColors.textBody, fontSize: 13),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _ProgressStrip(stage: _stage, icons: _stageIcons),
                  const SizedBox(height: AppSpacing.lg),
                  if (!isDelivered) _RiderCard() else const SizedBox.shrink(),
                  const SizedBox(height: AppSpacing.md),
                  PrimaryButton(
                    label: isDelivered ? 'Back to home' : 'Contact rider',
                    icon: isDelivered ? Icons.home_rounded : Icons.chat_bubble_outline_rounded,
                    onPressed: () {
                      if (isDelivered) {
                        CartScope.of(context).clear();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapMock extends StatelessWidget {
  final OrderStage stage;

  const _MapMock({required this.stage});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryLight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Simple road-like grid to suggest a map without a real map SDK.
          CustomPaint(
            size: Size.infinite,
            painter: _GridPainter(),
          ),
          Positioned(
            top: 40,
            left: 24,
            child: SvgPicture.asset(AppAssets.compass, height: 40),
          ),
          Positioned(
            bottom: 40,
            right: 32,
            child: Image.asset(AppAssets.mapPin, height: 36),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.dark.withOpacity(0.15),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: SvgPicture.asset(
                stage == OrderStage.onTheWay ? AppAssets.delivery : AppAssets.cloche,
                height: 46,
                colorFilter: const ColorFilter.mode(AppColors.primaryDark, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.18)
      ..strokeWidth = 1;
    const gap = 32.0;
    for (double x = 0; x < size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ProgressStrip extends StatelessWidget {
  final OrderStage stage;
  final Map<OrderStage, IconData> icons;

  const _ProgressStrip({required this.stage, required this.icons});

  @override
  Widget build(BuildContext context) {
    final stages = OrderStage.values;
    return Row(
      children: List.generate(stages.length * 2 - 1, (i) {
        if (i.isOdd) {
          final leftDone = stages[i ~/ 2].index <= stage.index;
          return Expanded(
            child: Container(
              height: 3,
              color: leftDone ? AppColors.primary : AppColors.border,
            ),
          );
        }
        final s = stages[i ~/ 2];
        final done = s.index <= stage.index;
        return Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: done ? AppColors.primary : AppColors.scaffold,
            shape: BoxShape.circle,
            border: Border.all(color: done ? AppColors.primary : AppColors.border),
          ),
          child: Icon(
            icons[s],
            size: 16,
            color: done ? Colors.white : AppColors.textBody,
          ),
        );
      }),
    );
  }
}

class _RiderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.scaffold,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage(AppAssets.avatar),
          ),
          const SizedBox(width: AppSpacing.sm),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Alex Rivera', style: TextStyle(fontWeight: FontWeight.w700)),
                Text(
                  'Your delivery rider',
                  style: TextStyle(color: AppColors.textBody, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.call_rounded, size: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
