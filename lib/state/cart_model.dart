import 'package:flutter/widgets.dart';

import '../models/food_item.dart';

/// Lightweight cart state shared across the app via [InheritedNotifier].
/// Kept dependency-free (no external state package) to stay easy to read.
class CartModel extends ChangeNotifier {
  final List<CartLine> _lines = [];

  List<CartLine> get lines => List.unmodifiable(_lines);

  int get itemCount => _lines.fold(0, (sum, line) => sum + line.quantity);

  double get subtotal =>
      _lines.fold(0, (sum, line) => sum + line.lineTotal);

  static const double deliveryFee = 2.50;

  double get total => _lines.isEmpty ? 0 : subtotal + deliveryFee;

  void add(FoodItem item, {int quantity = 1}) {
    final existingIndex = _lines.indexWhere((l) => l.item.id == item.id);
    if (existingIndex >= 0) {
      _lines[existingIndex].quantity += quantity;
    } else {
      _lines.add(CartLine(item: item, quantity: quantity));
    }
    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    final index = _lines.indexWhere((l) => l.item.id == itemId);
    if (index < 0) return;
    if (quantity <= 0) {
      _lines.removeAt(index);
    } else {
      _lines[index].quantity = quantity;
    }
    notifyListeners();
  }

  void remove(String itemId) {
    _lines.removeWhere((l) => l.item.id == itemId);
    notifyListeners();
  }

  void clear() {
    _lines.clear();
    notifyListeners();
  }
}

/// Provides [CartModel] down the widget tree without pulling in the
/// `provider` package.
class CartScope extends InheritedNotifier<CartModel> {
  const CartScope({
    super.key,
    required CartModel cart,
    required super.child,
  }) : super(notifier: cart);

  static CartModel of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'No CartScope found in context');
    return scope!.notifier!;
  }
}
