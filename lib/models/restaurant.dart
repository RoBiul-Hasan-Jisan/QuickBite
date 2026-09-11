/// A restaurant/vendor storefront on the platform.
class Restaurant {
  final String id;
  final String name;
  final String tagline;
  final List<String> cuisines;
  final String? coverImage;
  final double rating;
  final int reviewCount;
  final int deliveryTimeMinutes;
  final double deliveryFee;
  final double distanceKm;
  final String priceLevel; // '$', '$$', '$$$'
  final bool isOpen;
  final String? promoTag;

  const Restaurant({
    required this.id,
    required this.name,
    required this.tagline,
    required this.cuisines,
    this.coverImage,
    required this.rating,
    required this.reviewCount,
    required this.deliveryTimeMinutes,
    required this.deliveryFee,
    required this.distanceKm,
    required this.priceLevel,
    this.isOpen = true,
    this.promoTag,
  });

  String get deliveryFeeLabel =>
      deliveryFee == 0 ? 'Free delivery' : '\$${deliveryFee.toStringAsFixed(2)} delivery';
}

class Review {
  final String id;
  final String restaurantId;
  final String userName;
  final double rating;
  final String comment;
  final DateTime date;
  final int helpfulCount;

  const Review({
    required this.id,
    required this.restaurantId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
    this.helpfulCount = 0,
  });
}
