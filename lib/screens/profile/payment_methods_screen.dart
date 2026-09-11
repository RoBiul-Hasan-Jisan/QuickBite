import 'package:flutter/material.dart';

import '../../models/payment_method.dart';
import '../../state/payment_methods_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/primary_button.dart';
import 'add_card_screen.dart';

class PaymentMethodsScreen extends StatelessWidget {
  final bool selectionMode;

  const PaymentMethodsScreen({super.key, this.selectionMode = false});

  IconData _iconFor(CardBrand brand) {
    switch (brand) {
      case CardBrand.visa:
        return Icons.credit_card_rounded;
      case CardBrand.mastercard:
        return Icons.credit_card_rounded;
      case CardBrand.amex:
        return Icons.credit_card_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = PaymentMethodsScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectionMode ? 'Choose payment method' : 'Payment methods',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: AnimatedBuilder(
        animation: model,
        builder: (context, _) {
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: model.cards.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final card = model.cards[index];
              final selected = card.id == model.selected.id;
              return GestureDetector(
                onTap: () {
                  model.select(card.id);
                  if (selectionMode) Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                      color: selected ? AppColors.primary : AppColors.border,
                      width: selected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(_iconFor(card.brand), color: AppColors.primaryDark),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${card.brandLabel} •••• ${card.last4}',
                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                            const SizedBox(height: 2),
                            Text(card.holderName,
                                style: const TextStyle(color: AppColors.textBody, fontSize: 12)),
                          ],
                        ),
                      ),
                      Radio<String>(
                        value: card.id,
                        groupValue: model.selected.id,
                        activeColor: AppColors.primary,
                        onChanged: (_) {
                          model.select(card.id);
                          if (selectionMode) Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.md),
          child: PrimaryButton(
            label: 'Add new card',
            icon: Icons.add_card_rounded,
            onPressed: () =>
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddCardScreen())),
          ),
        ),
      ),
    );
  }
}
