import '../models/food_item.dart';
import '../models/restaurant.dart';

/// This is a single-restaurant app: everything the storefront serves
/// belongs to one restaurant, shown as its own product catalog.
const String kRestaurantId = 'r1';

const Restaurant kRestaurant = Restaurant(
  id: kRestaurantId,
  name: 'Fuzz Kitchen',
  tagline: 'Comfort food made fresh, from burgers to ramen',
  cuisines: ['Comfort food', 'Burgers', 'Asian', 'Healthy'],
  coverImage: null,
  rating: 4.8,
  reviewCount: 812,
  deliveryTimeMinutes: 20,
  deliveryFee: 1.99,
  distanceKm: 1.2,
  priceLevel: '\$\$',
  promoTag: '20% OFF today',
);

/// Kept so any code that still asks "which restaurant does this belong
/// to" keeps working even though there's only ever one.
Restaurant restaurantById(String id) => kRestaurant;

/// Menu-tab categories used to organize the product catalog.
const List<String> kMenuSections = [
  'Popular',
  'Mains',
  'Sides',
  'Drinks',
  'Desserts',
];

final List<FoodItem> kMenuItems = [
  const FoodItem(
    id: 'f1',
    restaurantId: kRestaurantId,
    name: 'Smoky BBQ Beef Burger',
    description:
        'Juicy grilled beef patty, smoky BBQ glaze, crisp lettuce, and melted cheddar on a toasted brioche bun.',
    price: 8.99,
    rating: 4.8,
    prepTimeMinutes: 15,
    category: 'Popular',
    tags: ['Bestseller'],
  ),
  const FoodItem(
    id: 'f15',
    restaurantId: kRestaurantId,
    name: 'Tonkotsu Ramen',
    description: 'Rich pork-bone broth, chashu pork, soft egg, nori, and scallions.',
    price: 13.50,
    rating: 4.9,
    prepTimeMinutes: 18,
    category: 'Popular',
    tags: ['Bestseller'],
  ),
  const FoodItem(
    id: 'f2',
    restaurantId: kRestaurantId,
    name: 'Margherita Wood-Fired Pizza',
    description:
        'Classic sourdough base with San Marzano tomatoes, fresh mozzarella, and basil straight from the wood oven.',
    price: 11.50,
    rating: 4.6,
    prepTimeMinutes: 20,
    category: 'Popular',
  ),
  const FoodItem(
    id: 'f7',
    restaurantId: kRestaurantId,
    name: 'Crispy Chicken Deluxe Burger',
    description: 'Golden fried chicken thigh, pickles, and spicy mayo stacked in a soft potato bun.',
    price: 9.25,
    rating: 4.6,
    prepTimeMinutes: 16,
    category: 'Mains',
  ),
  const FoodItem(
    id: 'f4',
    restaurantId: kRestaurantId,
    name: 'Double Cheese Pepperoni Pizza',
    description: 'A generous double layer of mozzarella with spicy pepperoni and a hint of oregano.',
    price: 12.25,
    rating: 4.9,
    prepTimeMinutes: 22,
    category: 'Mains',
    tags: ['Bestseller'],
  ),
  const FoodItem(
    id: 'f16',
    restaurantId: kRestaurantId,
    name: 'Spicy Miso Ramen',
    description: 'Miso broth with chili oil, ground pork, and bean sprouts.',
    price: 13.90,
    rating: 4.7,
    prepTimeMinutes: 18,
    category: 'Mains',
  ),
  const FoodItem(
    id: 'f8',
    restaurantId: kRestaurantId,
    name: 'Caesar Salad with Grilled Chicken',
    description: 'Romaine hearts, parmesan shavings, garlic croutons, and grilled chicken breast.',
    price: 7.90,
    rating: 4.3,
    prepTimeMinutes: 10,
    category: 'Mains',
    tags: ['Healthy'],
  ),
  const FoodItem(
    id: 'f13',
    restaurantId: kRestaurantId,
    name: 'Quinoa Power Bowl',
    description: 'Quinoa, roasted chickpeas, kale, and tahini dressing.',
    price: 8.20,
    rating: 4.6,
    prepTimeMinutes: 12,
    category: 'Mains',
    tags: ['Healthy'],
  ),
  const FoodItem(
    id: 'f9',
    restaurantId: kRestaurantId,
    name: 'Loaded Cheesy Fries',
    description: 'Crispy fries topped with melted cheddar, bacon bits, and scallions.',
    price: 4.50,
    rating: 4.5,
    prepTimeMinutes: 10,
    category: 'Sides',
  ),
  const FoodItem(
    id: 'f11',
    restaurantId: kRestaurantId,
    name: 'Garlic Focaccia Bread',
    description: 'Pillowy focaccia brushed with garlic butter and rosemary.',
    price: 3.95,
    rating: 4.4,
    prepTimeMinutes: 10,
    category: 'Sides',
  ),
  const FoodItem(
    id: 'f17',
    restaurantId: kRestaurantId,
    name: 'Gyoza (6 pcs)',
    description: 'Pan-fried pork and cabbage dumplings with ponzu dip.',
    price: 6.50,
    rating: 4.8,
    prepTimeMinutes: 10,
    category: 'Sides',
  ),
  const FoodItem(
    id: 'f3',
    restaurantId: kRestaurantId,
    name: 'Garden Harvest Salad',
    description: 'Crisp romaine, cherry tomatoes, cucumber, avocado, and a light citrus vinaigrette.',
    price: 6.75,
    rating: 4.4,
    prepTimeMinutes: 8,
    category: 'Sides',
    tags: ['Healthy'],
  ),
  const FoodItem(
    id: 'f10',
    restaurantId: kRestaurantId,
    name: 'Classic Root Beer Float',
    description: 'Ice-cold root beer with a scoop of vanilla ice cream.',
    price: 3.75,
    rating: 4.3,
    prepTimeMinutes: 5,
    category: 'Drinks',
  ),
  const FoodItem(
    id: 'f18',
    restaurantId: kRestaurantId,
    name: 'Iced Matcha Latte',
    description: 'Ceremonial-grade matcha whisked with cold milk over ice.',
    price: 4.75,
    rating: 4.6,
    prepTimeMinutes: 5,
    category: 'Drinks',
  ),
  const FoodItem(
    id: 'f6',
    restaurantId: kRestaurantId,
    name: 'Fresh Mango Iced Tea',
    description: 'Chilled black tea infused with ripe mango puree and a splash of mint.',
    price: 3.25,
    rating: 4.5,
    prepTimeMinutes: 5,
    category: 'Drinks',
    tags: ['New'],
  ),
  const FoodItem(
    id: 'f14',
    restaurantId: kRestaurantId,
    name: 'Cold-Pressed Green Juice',
    description: 'Spinach, apple, cucumber, and ginger, cold-pressed fresh.',
    price: 4.25,
    rating: 4.5,
    prepTimeMinutes: 4,
    category: 'Drinks',
  ),
  const FoodItem(
    id: 'f19',
    restaurantId: kRestaurantId,
    name: 'Pineapple Coconut Smoothie',
    description: 'Blended pineapple, coconut milk, and a touch of lime.',
    price: 4.90,
    rating: 4.8,
    prepTimeMinutes: 6,
    category: 'Drinks',
    tags: ['Bestseller'],
  ),
  const FoodItem(
    id: 'f12',
    restaurantId: kRestaurantId,
    name: 'Tiramisu',
    description: 'Layers of espresso-soaked ladyfingers and mascarpone cream.',
    price: 5.90,
    rating: 4.8,
    prepTimeMinutes: 5,
    category: 'Desserts',
  ),
  const FoodItem(
    id: 'f5',
    restaurantId: kRestaurantId,
    name: 'Molten Chocolate Lava Cake',
    description:
        'Warm chocolate cake with a gooey molten center, served with vanilla bean ice cream.',
    price: 5.50,
    rating: 4.7,
    prepTimeMinutes: 12,
    category: 'Desserts',
  ),
  const FoodItem(
    id: 'f20',
    restaurantId: kRestaurantId,
    name: 'Berry Yogurt Parfait',
    description: 'Layers of Greek yogurt, granola, and mixed berries.',
    price: 4.10,
    rating: 4.5,
    prepTimeMinutes: 5,
    category: 'Desserts',
  ),
];

/// All menu items belong to the one restaurant, but this stays around so
/// screens can keep asking "what's on the menu" the same way they would
/// in a multi-restaurant app.
List<FoodItem> menuForRestaurant(String restaurantId) => kMenuItems;

FoodItem foodById(String id) => kMenuItems.firstWhere((f) => f.id == id);

/// Hand-picked chef's picks shown at the top of the storefront.
List<FoodItem> get kPopularDishes => [
      foodById('f1'),
      foodById('f15'),
      foodById('f2'),
      foodById('f19'),
      foodById('f13'),
      foodById('f4'),
    ];
