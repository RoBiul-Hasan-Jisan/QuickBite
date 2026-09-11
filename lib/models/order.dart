import 'food_item.dart';

enum OrderStatus { onTheWay, delivered, cancelled }

class OrderRecord {
  final String id;
  final String restaurantId;
  final String restaurantName;
  final String? restaurantImage;
  final List<CartLine> lines;
  final double total;
  final DateTime placedAt;
  OrderStatus status;
  double? userRating;

  OrderRecord({
    required this.id,
    required this.restaurantId,
    required this.restaurantName,
    this.restaurantImage,
    required this.lines,
    required this.total,
    required this.placedAt,
    this.status = OrderStatus.onTheWay,
    this.userRating,
  });

  int get itemCount => lines.fold(0, (sum, l) => sum + l.quantity);
}
