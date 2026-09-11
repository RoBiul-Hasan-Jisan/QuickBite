import '../models/food_item.dart';
import '../models/order.dart';
import 'dummy_restaurants.dart';

List<OrderRecord> buildInitialOrders() {
  final order1Lines = [
    CartLine(item: foodById('f1'), quantity: 2),
    CartLine(item: foodById('f9'), quantity: 1),
  ];
  final order2Lines = [
    CartLine(item: foodById('f15'), quantity: 1),
    CartLine(item: foodById('f17'), quantity: 1),
  ];

  return [
    OrderRecord(
      id: 'ord1001',
      restaurantId: kRestaurant.id,
      restaurantName: kRestaurant.name,
      restaurantImage: kRestaurant.coverImage,
      lines: order1Lines,
      total: order1Lines.fold(0.0, (s, l) => s + l.lineTotal) + kRestaurant.deliveryFee,
      placedAt: DateTime(2026, 9, 6, 19, 30),
      status: OrderStatus.delivered,
      userRating: 5,
    ),
    OrderRecord(
      id: 'ord1000',
      restaurantId: kRestaurant.id,
      restaurantName: kRestaurant.name,
      restaurantImage: kRestaurant.coverImage,
      lines: order2Lines,
      total: order2Lines.fold(0.0, (s, l) => s + l.lineTotal) + kRestaurant.deliveryFee,
      placedAt: DateTime(2026, 8, 30, 13, 5),
      status: OrderStatus.delivered,
    ),
  ];
}
