import 'package:flutter/material.dart';

import '../../data/dummy_data.dart';
import '../../models/food_item.dart';
import '../../state/cart_model.dart';
import '../../theme/app_assets.dart';
import '../../theme/app_theme.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/food_card.dart';
import '../cart/cart_screen.dart';
import '../food_detail/food_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _category = 'All';
  final _searchController = TextEditingController();

  List<FoodItem> get _items {
    final base = menuByCategory(_category);
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return base;
    return base
        .where((item) => item.name.toLowerCase().contains(query))
        .toList();
  }

  void _openDetail(FoodItem item) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => FoodDetailScreen(item: item)),
    );
  }

  void _openCart() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CartScreen()),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: cart,
          builder: (context, _) {
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
                  sliver: SliverToBoxAdapter(
                    child: _Header(cartCount: cart.itemCount, onCartTap: _openCart),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                  sliver: SliverToBoxAdapter(
                    child: _SearchBar(controller: _searchController, onChanged: (_) => setState(() {})),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 44,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                      scrollDirection: Axis.horizontal,
                      itemCount: kCategories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        final cat = kCategories[index];
                        return CategoryChip(
                          label: cat,
                          selected: cat == _category,
                          onTap: () => setState(() => _category = cat),
                        );
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.lg),
                  sliver: _items.isEmpty
                      ? const SliverToBoxAdapter(child: _EmptyState())
                      : SliverGrid(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: AppSpacing.md,
                            crossAxisSpacing: AppSpacing.md,
                            childAspectRatio: 0.68,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final item = _items[index];
                              return FoodCard(
                                item: item,
                                onTap: () => _openDetail(item),
                                onAdd: () {
                                  cart.add(item);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(milliseconds: 900),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: AppColors.dark,
                                      content: Text('${item.name} added to cart'),
                                    ),
                                  );
                                },
                              );
                            },
                            childCount: _items.length,
                          ),
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

class _Header extends StatelessWidget {
  final int cartCount;
  final VoidCallback onCartTap;

  const _Header({required this.cartCount, required this.onCartTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(AppAssets.avatar),
        ),
        const SizedBox(width: AppSpacing.md),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deliver to',
                style: TextStyle(color: AppColors.textBody, fontSize: 12),
              ),
              Row(
                children: [
                  Icon(Icons.location_on_rounded, color: AppColors.primary, size: 16),
                  SizedBox(width: 2),
                  Text(
                    '221B Baker Street',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onCartTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.scaffold,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(Icons.shopping_bag_outlined, color: AppColors.dark),
              ),
              if (cartCount > 0)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.danger,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                    child: Text(
                      '$cartCount',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: const InputDecoration(
        hintText: 'Search dishes, cuisines...',
        prefixIcon: Icon(Icons.search_rounded),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
      child: Column(
        children: const [
          Icon(Icons.ramen_dining_outlined, size: 48, color: AppColors.textBody),
          SizedBox(height: AppSpacing.sm),
          Text(
            'No dishes found',
            style: TextStyle(color: AppColors.textBody),
          ),
        ],
      ),
    );
  }
}
