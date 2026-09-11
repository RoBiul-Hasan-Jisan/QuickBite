import '../models/restaurant.dart';
import 'dummy_restaurants.dart';

final List<Review> kReviews = [
  Review(
    id: 'rv1',
    restaurantId: kRestaurantId,
    userName: 'Jordan M.',
    rating: 5,
    comment:
        'The BBQ burger is unreal — smoky, juicy, and the bun was perfectly toasted. Fast delivery too.',
    date: DateTime(2026, 8, 28),
    helpfulCount: 24,
  ),
  Review(
    id: 'rv2',
    restaurantId: kRestaurantId,
    userName: 'Yuki N.',
    rating: 5,
    comment: 'Best tonkotsu ramen in the city, hands down. Broth is rich and comforting.',
    date: DateTime(2026, 9, 5),
    helpfulCount: 42,
  ),
  Review(
    id: 'rv3',
    restaurantId: kRestaurantId,
    userName: 'Marco D.',
    rating: 5,
    comment: 'Tastes like an actual Naples pizzeria. The Margherita is simple but perfect.',
    date: DateTime(2026, 9, 1),
    helpfulCount: 31,
  ),
  Review(
    id: 'rv4',
    restaurantId: kRestaurantId,
    userName: 'Priya K.',
    rating: 4.5,
    comment: 'Great burgers, fries could be a bit crispier next time.',
    date: DateTime(2026, 8, 20),
    helpfulCount: 9,
  ),
  Review(
    id: 'rv5',
    restaurantId: kRestaurantId,
    userName: 'Sam T.',
    rating: 4.5,
    comment: 'Super fresh ingredients on the salads, my go-to for a quick healthy lunch.',
    date: DateTime(2026, 8, 30),
    helpfulCount: 14,
  ),
  Review(
    id: 'rv6',
    restaurantId: kRestaurantId,
    userName: 'Chris B.',
    rating: 4.5,
    comment: 'Gyoza were crispy and delicious, will definitely order again.',
    date: DateTime(2026, 8, 22),
    helpfulCount: 11,
  ),
  Review(
    id: 'rv7',
    restaurantId: kRestaurantId,
    userName: 'Lena F.',
    rating: 5,
    comment: 'The pineapple coconut smoothie is so refreshing, perfect summer treat.',
    date: DateTime(2026, 9, 3),
    helpfulCount: 18,
  ),
];

List<Review> reviewsForRestaurant(String restaurantId) => kReviews;
