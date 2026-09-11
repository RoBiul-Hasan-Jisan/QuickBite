import '../models/food_item.dart';
import '../theme/app_assets.dart';

const List<String> kCategories = [
  'All',
  'Burgers',
  'Pizza',
  'Salads',
  'Desserts',
  'Drinks',
];

final List<FoodItem> kMenuItems = [
  const FoodItem(
    id: 'f1',
    name: 'Smoky BBQ Beef Burger',
    description:
        'Juicy grilled beef patty, smoky BBQ glaze, crisp lettuce, and melted cheddar on a toasted brioche bun.',
    price: 8.99,
    image: AppAssets.placeholder,
    rating: 4.8,
    prepTimeMinutes: 15,
    category: 'Burgers',
    tags: ['Bestseller'],
  ),
  const FoodItem(
    id: 'f2',
    name: 'Margherita Wood-Fired Pizza',
    description:
        'Classic sourdough base with San Marzano tomatoes, fresh mozzarella, and basil straight from the wood oven.',
    price: 11.50,
    image: AppAssets.recipes,
    rating: 4.6,
    prepTimeMinutes: 20,
    category: 'Pizza',
  ),
  const FoodItem(
    id: 'f3',
    name: 'Garden Harvest Salad',
    description:
        'Crisp romaine, cherry tomatoes, cucumber, avocado, and a light citrus vinaigrette.',
    price: 6.75,
    image: AppAssets.placeholder,
    rating: 4.4,
    prepTimeMinutes: 8,
    category: 'Salads',
    tags: ['Healthy'],
  ),
  const FoodItem(
    id: 'f4',
    name: 'Double Cheese Pepperoni',
    description:
        'A generous double layer of mozzarella with spicy pepperoni and a hint of oregano.',
    price: 12.25,
    image: AppAssets.recipes,
    rating: 4.9,
    prepTimeMinutes: 22,
    category: 'Pizza',
    tags: ['Bestseller'],
  ),
  const FoodItem(
    id: 'f5',
    name: 'Molten Chocolate Lava Cake',
    description:
        'Warm chocolate cake with a gooey molten center, served with vanilla bean ice cream.',
    price: 5.50,
    image: AppAssets.placeholder,
    rating: 4.7,
    prepTimeMinutes: 12,
    category: 'Desserts',
  ),
  const FoodItem(
    id: 'f6',
    name: 'Fresh Mango Iced Tea',
    description:
        'Chilled black tea infused with ripe mango puree and a splash of mint.',
    price: 3.25,
    image: AppAssets.recipes,
    rating: 4.5,
    prepTimeMinutes: 5,
    category: 'Drinks',
    tags: ['New'],
  ),
  const FoodItem(
    id: 'f7',
    name: 'Crispy Chicken Deluxe Burger',
    description:
        'Golden fried chicken thigh, pickles, and spicy mayo stacked in a soft potato bun.',
    price: 9.25,
    image: AppAssets.placeholder,
    rating: 4.6,
    prepTimeMinutes: 16,
    category: 'Burgers',
  ),
  const FoodItem(
    id: 'f8',
    name: 'Caesar Salad with Grilled Chicken',
    description:
        'Romaine hearts, parmesan shavings, garlic croutons, and grilled chicken breast.',
    price: 7.90,
    image: AppAssets.recipes,
    rating: 4.3,
    prepTimeMinutes: 10,
    category: 'Salads',
  ),
];

List<FoodItem> menuByCategory(String category) {
  if (category == 'All') return kMenuItems;
  return kMenuItems.where((item) => item.category == category).toList();
}
