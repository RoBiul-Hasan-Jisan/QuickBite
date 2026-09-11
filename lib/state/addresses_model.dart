import 'package:flutter/widgets.dart';

import '../data/dummy_addresses.dart';
import '../models/address.dart';

class AddressesModel extends ChangeNotifier {
  final List<Address> _addresses = List.of(kInitialAddresses);
  String _selectedId = kInitialAddresses.first.id;

  List<Address> get addresses => List.unmodifiable(_addresses);

  Address get selected =>
      _addresses.firstWhere((a) => a.id == _selectedId, orElse: () => _addresses.first);

  void select(String id) {
    _selectedId = id;
    notifyListeners();
  }

  void add(Address address) {
    _addresses.add(address);
    if (address.isDefault) {
      _selectedId = address.id;
    }
    notifyListeners();
  }

  void remove(String id) {
    _addresses.removeWhere((a) => a.id == id);
    if (_selectedId == id && _addresses.isNotEmpty) {
      _selectedId = _addresses.first.id;
    }
    notifyListeners();
  }
}

class AddressesScope extends InheritedNotifier<AddressesModel> {
  const AddressesScope({
    super.key,
    required AddressesModel addresses,
    required super.child,
  }) : super(notifier: addresses);

  static AddressesModel of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AddressesScope>();
    assert(scope != null, 'No AddressesScope found in context');
    return scope!.notifier!;
  }
}
