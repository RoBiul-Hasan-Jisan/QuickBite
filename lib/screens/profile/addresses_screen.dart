import 'package:flutter/material.dart';

import '../../state/addresses_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/primary_button.dart';
import 'add_address_screen.dart';

class AddressesScreen extends StatelessWidget {
  final bool selectionMode;

  const AddressesScreen({super.key, this.selectionMode = false});

  @override
  Widget build(BuildContext context) {
    final model = AddressesScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectionMode ? 'Choose address' : 'Delivery addresses',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: AnimatedBuilder(
        animation: model,
        builder: (context, _) {
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: model.addresses.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final address = model.addresses[index];
              final selected = address.id == model.selected.id;
              return GestureDetector(
                onTap: () {
                  model.select(address.id);
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
                      Icon(
                        address.label == 'Home'
                            ? Icons.home_rounded
                            : address.label == 'Work'
                                ? Icons.work_rounded
                                : Icons.location_on_rounded,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(address.label,
                                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                                if (address.isDefault) ...[
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryLight,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text('Default',
                                        style: TextStyle(fontSize: 10, color: AppColors.primaryDark)),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text('${address.line1}, ${address.line2}',
                                style: const TextStyle(color: AppColors.textBody, fontSize: 12)),
                          ],
                        ),
                      ),
                      Radio<String>(
                        value: address.id,
                        groupValue: model.selected.id,
                        activeColor: AppColors.primary,
                        onChanged: (_) {
                          model.select(address.id);
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
            label: 'Add new address',
            icon: Icons.add_location_alt_outlined,
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const AddAddressScreen())),
          ),
        ),
      ),
    );
  }
}
