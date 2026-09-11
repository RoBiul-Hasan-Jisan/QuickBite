import 'package:flutter/material.dart';

import '../../data/dummy_restaurants.dart';
import '../../models/food_item.dart';
import '../../state/cart_model.dart';
import '../../theme/app_theme.dart';
import '../../utils/cart_helpers.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/food_card.dart';
import '../food_detail/food_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

enum _Filter { bestseller, healthy, under5 }

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  final Set<_Filter> _activeFilters = {};
  final List<String> _recentSearches = ['Burger', 'Ramen', 'Smoothie'];

  List<FoodItem> get _results {
    var results = kMenuItems.where((f) {
      final query = _controller.text.trim().toLowerCase();
      if (query.isEmpty) return true;
      return f.name.toLowerCase().contains(query) ||
          f.category.toLowerCase().contains(query);
    }).toList();

    if (_activeFilters.contains(_Filter.bestseller)) {
      results = results.where((f) => f.tags.contains('Bestseller')).toList();
    }
    if (_activeFilters.contains(_Filter.healthy)) {
      results = results.where((f) => f.tags.contains('Healthy')).toList();
    }
    if (_activeFilters.contains(_Filter.under5)) {
      results = results.where((f) => f.price < 5).toList();
    }
    return results;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasQuery = _controller.text.trim().isNotEmpty || _activeFilters.isNotEmpty;
    final cart = CartScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search menu', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: AnimatedBuilder(
        animation: cart,
        builder: (context, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.sm),
                child: TextField(
                  controller: _controller,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search dishes, categories...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: _controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () => setState(_controller.clear),
                          )
                        : null,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _FilterChip(
                      label: 'Bestsellers',
                      selected: _activeFilters.contains(_Filter.bestseller),
                      onTap: () => setState(() => _toggleFilter(_Filter.bestseller)),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _FilterChip(
                      label: 'Healthy',
                      selected: _activeFilters.contains(_Filter.healthy),
                      onTap: () => setState(() => _toggleFilter(_Filter.healthy)),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _FilterChip(
                      label: 'Under \$5',
                      selected: _activeFilters.contains(_Filter.under5),
                      onTap: () => setState(() => _toggleFilter(_Filter.under5)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: !hasQuery
                    ? _RecentSearches(
                        terms: _recentSearches,
                        onTap: (term) {
                          _controller.text = term;
                          setState(() {});
                        },
                      )
                    : (_results.isEmpty)
                        ? const EmptyState(
                            icon: Icons.search_off_rounded,
                            title: 'No dishes found',
                            message: 'Try a different search term or clear your filters.',
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.fromLTRB(
                                AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.xl),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: AppSpacing.md,
                              crossAxisSpacing: AppSpacing.md,
                              childAspectRatio: 0.68,
                            ),
                            itemCount: _results.length,
                            itemBuilder: (context, index) {
                              final item = _results[index];
                              return FoodCard(
                                item: item,
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) => FoodDetailScreen(item: item)),
                                ),
                                onAdd: () => addToCartSafely(context, cart, item),
                              );
                            },
                          ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _toggleFilter(_Filter filter) {
    if (!_activeFilters.remove(filter)) {
      _activeFilters.add(filter);
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.scaffold,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? AppColors.primary : AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppColors.textBody,
          ),
        ),
      ),
    );
  }
}

class _RecentSearches extends StatelessWidget {
  final List<String> terms;
  final ValueChanged<String> onTap;

  const _RecentSearches({required this.terms, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (terms.isEmpty) {
      return const EmptyState(
        icon: Icons.search_rounded,
        title: 'Search the menu',
        message: 'Find your favorite dishes fast.',
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent searches', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: terms
                .map(
                  (term) => GestureDetector(
                    onTap: () => onTap(term),
                    child: Chip(
                      label: Text(term),
                      backgroundColor: AppColors.scaffold,
                      avatar: const Icon(Icons.history_rounded, size: 16),
                      side: const BorderSide(color: AppColors.border),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
