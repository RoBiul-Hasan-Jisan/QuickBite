import 'package:flutter/widgets.dart';

import '../data/dummy_orders.dart';
import '../models/order.dart';

class OrdersModel extends ChangeNotifier {
  final List<OrderRecord> _orders = buildInitialOrders();

  List<OrderRecord> get orders =>
      List.unmodifiable(_orders..sort((a, b) => b.placedAt.compareTo(a.placedAt)));

  List<OrderRecord> get activeOrders =>
      _orders.where((o) => o.status == OrderStatus.onTheWay).toList();

  void addOrder(OrderRecord order) {
    _orders.insert(0, order);
    notifyListeners();
  }

  void markDelivered(String orderId) {
    final order = _orders.firstWhere((o) => o.id == orderId);
    order.status = OrderStatus.delivered;
    notifyListeners();
  }

  void rateOrder(String orderId, double rating) {
    final order = _orders.firstWhere((o) => o.id == orderId);
    order.userRating = rating;
    notifyListeners();
  }
}

class OrdersScope extends InheritedNotifier<OrdersModel> {
  const OrdersScope({
    super.key,
    required OrdersModel orders,
    required super.child,
  }) : super(notifier: orders);

  static OrdersModel of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<OrdersScope>();
    assert(scope != null, 'No OrdersScope found in context');
    return scope!.notifier!;
  }
}
