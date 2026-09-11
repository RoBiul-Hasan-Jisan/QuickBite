class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final double rating;
  final int prepTimeMinutes;
  final String category;
  final List<String> tags;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.prepTimeMinutes,
    required this.category,
    this.tags = const [],
  });
}

class CartLine {
  final FoodItem item;
  int quantity;
  final String? note;

  CartLine({required this.item, this.quantity = 1, this.note});

  double get lineTotal => item.price * quantity;
}
