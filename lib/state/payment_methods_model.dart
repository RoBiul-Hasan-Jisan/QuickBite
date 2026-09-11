import 'package:flutter/widgets.dart';

import '../data/dummy_payment_methods.dart';
import '../models/payment_method.dart';

class PaymentMethodsModel extends ChangeNotifier {
  final List<PaymentCard> _cards = List.of(kInitialCards);
  String _selectedId = kInitialCards.first.id;

  List<PaymentCard> get cards => List.unmodifiable(_cards);

  PaymentCard get selected =>
      _cards.firstWhere((c) => c.id == _selectedId, orElse: () => _cards.first);

  void select(String id) {
    _selectedId = id;
    notifyListeners();
  }

  void add(PaymentCard card) {
    _cards.add(card);
    if (card.isDefault) {
      _selectedId = card.id;
    }
    notifyListeners();
  }

  void remove(String id) {
    _cards.removeWhere((c) => c.id == id);
    if (_selectedId == id && _cards.isNotEmpty) {
      _selectedId = _cards.first.id;
    }
    notifyListeners();
  }
}

class PaymentMethodsScope extends InheritedNotifier<PaymentMethodsModel> {
  const PaymentMethodsScope({
    super.key,
    required PaymentMethodsModel methods,
    required super.child,
  }) : super(notifier: methods);

  static PaymentMethodsModel of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<PaymentMethodsScope>();
    assert(scope != null, 'No PaymentMethodsScope found in context');
    return scope!.notifier!;
  }
}
