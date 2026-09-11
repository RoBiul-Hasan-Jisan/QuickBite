import 'package:flutter/material.dart';

import '../../state/cart_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../cart/cart_screen.dart';
import '../favorites/favorites_screen.dart';
import '../home/home_screen.dart';
import '../orders/orders_screen.dart';
import '../profile/profile_screen.dart';
import '../search/search_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _screens = [
    HomeScreen(),
    SearchScreen(),
    OrdersScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);

    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
      floatingActionButton: AnimatedBuilder(
        animation: cart,
        builder: (context, _) {
          if (cart.itemCount == 0) return const SizedBox.shrink();
          return Padding(
            padding: const EdgeInsets.only(bottom: 56),
            child: FloatingActionButton.extended(
              backgroundColor: AppColors.primary,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CartScreen()),
                );
              },
              icon: const Icon(Icons.shopping_bag_rounded, color: Colors.white),
              label: Text(
                '${cart.itemCount} · \$${cart.subtotal.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
          );
        },
      ),
    );
  }
}
