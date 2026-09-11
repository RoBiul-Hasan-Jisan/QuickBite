import 'package:flutter/material.dart';

import '../../models/address.dart';
import '../../state/addresses_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/primary_button.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _labelController = TextEditingController(text: 'Home');
  final _line1Controller = TextEditingController();
  final _line2Controller = TextEditingController();
  bool _setDefault = false;

  @override
  void dispose() {
    _labelController.dispose();
    _line1Controller.dispose();
    _line2Controller.dispose();
    super.dispose();
  }

  void _save() {
    if (_line1Controller.text.trim().isEmpty) return;
    final model = AddressesScope.of(context);
    model.add(
      Address(
        id: 'a${DateTime.now().millisecondsSinceEpoch}',
        label: _labelController.text.trim().isEmpty ? 'Other' : _labelController.text.trim(),
        line1: _line1Controller.text.trim(),
        line2: _line2Controller.text.trim(),
        isDefault: _setDefault,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add address', style: TextStyle(fontWeight: FontWeight.w700))),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          TextField(
            controller: _labelController,
            decoration: const InputDecoration(
              hintText: 'Label (e.g. Home, Work)',
              prefixIcon: Icon(Icons.label_outline_rounded),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _line1Controller,
            decoration: const InputDecoration(
              hintText: 'Street address',
              prefixIcon: Icon(Icons.location_on_outlined),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _line2Controller,
            decoration: const InputDecoration(
              hintText: 'City, area / apartment',
              prefixIcon: Icon(Icons.map_outlined),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SwitchListTile(
            value: _setDefault,
            onChanged: (v) => setState(() => _setDefault = v),
            activeColor: AppColors.primary,
            contentPadding: EdgeInsets.zero,
            title: const Text('Set as default address', style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.md),
          child: PrimaryButton(label: 'Save address', onPressed: _save),
        ),
      ),
    );
  }
}
