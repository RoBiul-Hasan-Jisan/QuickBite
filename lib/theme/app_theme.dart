import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central design tokens for Fuzz App.
/// Palette is pulled from the Fuzz App logo: warm amber/orange as the
/// primary brand color, with a deep coffee-brown for text and accents.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFFA726); // warm amber/orange
  static const Color primaryDark = Color(0xFFF57C00);
  static const Color primaryLight = Color(0xFFFFE0B2);

  static const Color dark = Color(0xFF3A2A1E); // deep coffee brown
  static const Color textBody = Color(0xFF7A6F68);
  static const Color background = Color(0xFFFFFFFF);
  static const Color scaffold = Color(0xFFFAF9F7);
  static const Color card = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFF0EBE7);

  static const Color success = Color(0xFF4CAF50);
  static const Color danger = Color(0xFFE85D4A);
  static const Color star = Color(0xFFFFC107);

  static const List<Color> primaryGradient = [
    Color(0xFFFFB74D),
    Color(0xFFF57C00),
  ];
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.primaryDark,
        surface: AppColors.background,
      ),
      scaffoldBackgroundColor: AppColors.scaffold,
      fontFamily: GoogleFonts.poppins().fontFamily,
    );

    return base.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).apply(
        bodyColor: AppColors.dark,
        displayColor: AppColors.dark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: AppColors.dark),
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          elevation: 0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.scaffold,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: const TextStyle(color: AppColors.textBody),
      ),
    );
  }
}

class AppRadius {
  AppRadius._();
  static const double sm = 12;
  static const double md = 18;
  static const double lg = 24;
  static const double xl = 32;
}

class AppSpacing {
  AppSpacing._();
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

/// Deterministic decorative gradients used behind restaurant covers and
/// dish thumbnails that don't have a real bundled photo, keyed by a
/// category/cuisine string so the same dish/restaurant always renders the
/// same way.
class AppPalette {
  AppPalette._();

  static const List<List<Color>> _gradients = [
    [Color(0xFFFFB74D), Color(0xFFF57C00)], // amber
    [Color(0xFFEF5350), Color(0xFFC62828)], // red
    [Color(0xFF66BB6A), Color(0xFF2E7D32)], // green
    [Color(0xFFEC407A), Color(0xFFAD1457)], // pink
    [Color(0xFF42A5F5), Color(0xFF1565C0)], // blue
    [Color(0xFFAB47BC), Color(0xFF6A1B9A)], // purple
  ];

  static List<Color> gradientFor(String key) {
    final index = key.codeUnits.fold<int>(0, (a, b) => a + b) % _gradients.length;
    return _gradients[index];
  }

  static IconData iconForCategory(String category) {
    switch (category) {
      case 'Burgers':
      case 'Mains':
        return Icons.lunch_dining_rounded;
      case 'Pizza':
        return Icons.local_pizza_rounded;
      case 'Salads':
      case 'Healthy':
        return Icons.eco_rounded;
      case 'Desserts':
        return Icons.icecream_rounded;
      case 'Drinks':
        return Icons.local_bar_rounded;
      case 'Sides':
        return Icons.tapas_rounded;
      case 'Asian':
      case 'Japanese':
        return Icons.ramen_dining_rounded;
      case 'Popular':
        return Icons.local_fire_department_rounded;
      default:
        return Icons.restaurant_rounded;
    }
  }
}
