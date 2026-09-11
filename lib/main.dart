import 'package:flutter/material.dart';

import 'screens/splash/splash_screen.dart';
import 'state/cart_model.dart';
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

  @override
  void dispose() {
    _cart.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CartScope(
      cart: _cart,
      child: MaterialApp(
        title: 'Fuzz App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const SplashScreen(),
      ),
    );
  }
}
