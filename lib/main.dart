import 'package:flutter/material.dart';

import 'screens/splash/splash_screen.dart';
import 'state/addresses_model.dart';
import 'state/cart_model.dart';
import 'state/favorites_model.dart';
import 'state/orders_model.dart';
import 'state/payment_methods_model.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const FuzzApp());
}

class FuzzApp extends StatefulWidget {
  const FuzzApp({super.key});

  @override
  State<FuzzApp> createState() => _FuzzAppState();
}

class _FuzzAppState extends State<FuzzApp> {
  final _cart = CartModel();
  final _favorites = FavoritesModel();
  final _orders = OrdersModel();
  final _addresses = AddressesModel();
  final _paymentMethods = PaymentMethodsModel();

  @override
  void dispose() {
    _cart.dispose();
    _favorites.dispose();
    _orders.dispose();
    _addresses.dispose();
    _paymentMethods.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CartScope(
      cart: _cart,
      child: FavoritesScope(
        favorites: _favorites,
        child: OrdersScope(
          orders: _orders,
          child: AddressesScope(
            addresses: _addresses,
            child: PaymentMethodsScope(
              methods: _paymentMethods,
              child: MaterialApp(
                title: 'Fuzz App',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                home: const SplashScreen(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
