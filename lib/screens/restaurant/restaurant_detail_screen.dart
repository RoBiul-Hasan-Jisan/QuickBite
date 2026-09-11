import 'package:flutter/material.dart';

import '../../data/dummy_restaurants.dart';
import '../../data/dummy_reviews.dart';
import '../../models/food_item.dart';
import '../../models/restaurant.dart';
import '../../state/cart_model.dart';
import '../../state/favorites_model.dart';
import '../../theme/app_theme.dart';
import '../../utils/cart_helpers.dart';
import '../../widgets/dish_thumbnail.dart';
import '../../widgets/restaurant_cover.dart';
import '../../widgets/review_card.dart';
import '../food_detail/food_detail_screen.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetailScreen({super.key, required this.restaurantId});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  String _menuSection = 'Popular';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = restaurantById(widget.restaurantId);
    final menu = menuForRestaurant(restaurant.id);
    final sections = kMenuSections.where((s) => menu.any((m) => m.category == s)).toList();
    final reviews = reviewsForRestaurant(restaurant.id);
    final cart = CartScope.of(context);
    final favorites = FavoritesScope.of(context);

    if (!sections.contains(_menuSection) && sections.isNotEmpty) {
      _menuSection = sections.first;
    }

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([cart, favorites]),
        builder: (context, _) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 220,
                pinned: true,
                backgroundColor: AppColors.background,
                leading: Padding(
                  padding: const EdgeInsets.all(8),
                  child: _RoundButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: _RoundButton(
                      icon: favorites.isRestaurantFavorite(restaurant.id)
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      iconColor: favorites.isRestaurantFavorite(restaurant.id)
                          ? AppColors.danger
                          : AppColors.dark,
                      onTap: () => favorites.toggleRestaurant(restaurant.id),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: RestaurantCover(restaurant: restaurant),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        restaurant.tagline,
                        style: const TextStyle(color: AppColors.textBody, fontSize: 13),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: 8,
                        children: [
                          _InfoChip(icon: Icons.star_rounded, label: '${restaurant.rating} (${restaurant.reviewCount})', color: AppColors.star),
                          _InfoChip(icon: Icons.timer_outlined, label: '${restaurant.deliveryTimeMinutes} min', color: AppColors.primary),
                          _InfoChip(icon: Icons.pedal_bike_rounded, label: restaurant.deliveryFeeLabel, color: AppColors.success),
                          _InfoChip(icon: Icons.attach_money_rounded, label: restaurant.priceLevel, color: AppColors.primaryDark),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _TabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primaryDark,
                    unselectedLabelColor: AppColors.textBody,
                    indicatorColor: AppColors.primary,
                    labelStyle: const TextStyle(fontWeight: FontWeight.w700),
                    tabs: const [Tab(text: 'Menu'), Tab(text: 'Reviews')],
                  ),
                ),
              ),
            ],
            body: TabBarView(
              controller: _tabController,
              children: [
                _MenuTab(
                  sections: sections,
                  selectedSection: _menuSection,
                  onSectionSelected: (s) => setState(() => _menuSection = s),
                  items: menu.where((m) => m.category == _menuSection).toList(),
                  onAdd: (item) {
                    addToCartSafely(context, cart, item);
                  },
                ),
                _ReviewsTab(reviews: reviews, restaurantRating: restaurant.rating),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MenuTab extends StatelessWidget {
  final List<String> sections;
  final String selectedSection;
  final ValueChanged<String> onSectionSelected;
  final List<FoodItem> items;
  final ValueChanged<FoodItem> onAdd;

  const _MenuTab({
    required this.sections,
    required this.selectedSection,
    required this.onSectionSelected,
    required this.items,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            scrollDirection: Axis.horizontal,
            itemCount: sections.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              final section = sections[index];
              final selected = section == selectedSection;
              return ChoiceChip(
                label: Text(section),
                selected: selected,
                onSelected: (_) => onSectionSelected(section),
                selectedColor: AppColors.primary,
                backgroundColor: AppColors.scaffold,
                labelStyle: TextStyle(
                  color: selected ? Colors.white : AppColors.textBody,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                side: BorderSide(color: selected ? AppColors.primary : AppColors.border),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.xl),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => FoodDetailScreen(item: item)),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 76,
                        height: 76,
                        child: DishThumbnail(item: item, borderRadius: AppRadius.sm),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: AppColors.textBody, fontSize: 12),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => onAdd(item),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add_rounded, size: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ReviewsTab extends StatelessWidget {
  final List<Review> reviews;
  final double restaurantRating;

  const _ReviewsTab({required this.reviews, required this.restaurantRating});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Center(
        child: Text('No reviews yet', style: TextStyle(color: AppColors.textBody)),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xl),
      itemCount: reviews.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) => ReviewCard(review: reviews[index]),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: AppColors.background, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant _TabBarDelegate oldDelegate) => false;
}

class _RoundButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTap;

  const _RoundButton({required this.icon, this.iconColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 18, color: iconColor ?? AppColors.dark),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}
