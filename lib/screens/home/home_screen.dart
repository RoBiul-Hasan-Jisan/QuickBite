import 'package:flutter/material.dart';

import '../../data/dummy_restaurants.dart';
import '../../data/dummy_reviews.dart';
import '../../state/cart_model.dart';
import '../../state/favorites_model.dart';
import '../../theme/app_assets.dart';
import '../../theme/app_theme.dart';
import '../../utils/cart_helpers.dart';
import '../../widgets/food_card.dart';
import '../../widgets/promo_banner.dart';
import '../../widgets/restaurant_cover.dart';
import '../../widgets/review_card.dart';
import '../../widgets/section_header.dart';
import '../food_detail/food_detail_screen.dart';
import '../profile/notifications_screen.dart';
import '../reviews/reviews_screen.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _section = 'Popular';

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final favorites = FavoritesScope.of(context);
    final menu = menuForRestaurant(kRestaurant.id);
    final sectionItems = menu.where((item) => item.category == _section).toList();
    final reviews = reviewsForRestaurant(kRestaurant.id).take(2).toList();

    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: Listenable.merge([cart, favorites]),
          builder: (context, _) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 190,
                    child: RestaurantCover(
                      restaurant: kRestaurant,
                      overlay: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Image.asset(AppAssets.logo),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        kRestaurant.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Text(
                                        kRestaurant.tagline,
                                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                                    ),
                                    child: const Icon(Icons.notifications_none_rounded,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        _InfoChip(icon: Icons.star_rounded, label: '${kRestaurant.rating} (${kRestaurant.reviewCount})', color: AppColors.star),
                        const SizedBox(width: AppSpacing.sm),
                        _InfoChip(icon: Icons.timer_outlined, label: '${kRestaurant.deliveryTimeMinutes} min', color: AppColors.primary),
                        const SizedBox(width: AppSpacing.sm),
                        _InfoChip(icon: Icons.pedal_bike_rounded, label: kRestaurant.deliveryFeeLabel, color: AppColors.success),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                  sliver: SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SearchScreen()),
                      ),
                      child: const AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search the menu...',
                            prefixIcon: Icon(Icons.search_rounded),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  sliver: SliverToBoxAdapter(
                    child: SizedBox(
                      height: 110,
                      child: PromoBanner(
                        title: kRestaurant.promoTag ?? 'Special offer',
                        subtitle: 'Use code FUZZ20 at checkout',
                        icon: Icons.local_offer_rounded,
                        colors: AppPalette.gradientFor('promo'),
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                      AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 0),
                  sliver: SliverToBoxAdapter(
                    child: SectionHeader(title: "Chef's picks"),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 210,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                      scrollDirection: Axis.horizontal,
                      itemCount: kPopularDishes.length,
                      separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
                      itemBuilder: (context, index) {
                        final item = kPopularDishes[index];
                        return SizedBox(
                          width: 150,
                          child: FoodCard(
                            item: item,
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => FoodDetailScreen(item: item)),
                            ),
                            onAdd: () => addToCartSafely(context, cart, item),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
                  sliver: SliverToBoxAdapter(child: SectionHeader(title: 'Full menu')),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 44,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                      scrollDirection: Axis.horizontal,
                      itemCount: kMenuSections.length,
                      separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        final section = kMenuSections[index];
                        final selected = section == _section;
                        return ChoiceChip(
                          label: Text(section),
                          selected: selected,
                          onSelected: (_) => setState(() => _section = section),
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
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: AppSpacing.md,
                      crossAxisSpacing: AppSpacing.md,
                      childAspectRatio: 0.68,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item = sectionItems[index];
                        return FoodCard(
                          item: item,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => FoodDetailScreen(item: item)),
                          ),
                          onAdd: () => addToCartSafely(context, cart, item),
                        );
                      },
                      childCount: sectionItems.length,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.lg, 0, AppSpacing.lg, 0),
                  sliver: SliverToBoxAdapter(
                    child: SectionHeader(
                      title: 'Reviews',
                      actionLabel: 'See all',
                      onAction: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ReviewsScreen()),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xl),
                  sliver: SliverList.separated(
                    itemCount: reviews.length,
                    separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) => ReviewCard(review: reviews[index]),
                  ),
                ),
              ],
            );
          },
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
