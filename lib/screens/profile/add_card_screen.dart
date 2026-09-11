import 'package:flutter/material.dart';

import '../../models/payment_method.dart';
import '../../state/payment_methods_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/primary_button.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _save() {
    final digits = _numberController.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 4 || _nameController.text.trim().isEmpty) return;

    final model = PaymentMethodsScope.of(context);
    model.add(
      PaymentCard(
        id: 'c${DateTime.now().millisecondsSinceEpoch}',
        brand: digits.startsWith('4') ? CardBrand.visa : CardBrand.mastercard,
        last4: digits.substring(digits.length - 4),
        holderName: _nameController.text.trim(),
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add card', style: TextStyle(fontWeight: FontWeight.w700))),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Cardholder name',
              prefixIcon: Icon(Icons.person_outline_rounded),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _numberController,
            keyboardType: TextInputType.number,
            maxLength: 19,
            decoration: const InputDecoration(
              hintText: 'Card number',
              prefixIcon: Icon(Icons.credit_card_rounded),
              counterText: '',
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _expiryController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'MM/YY'),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: TextField(
                  controller: _cvvController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: 'CVV'),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.md),
          child: PrimaryButton(label: 'Save card', onPressed: _save),
        ),
      ),
    );
  }
}
