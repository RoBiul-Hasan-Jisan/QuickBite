/// Central registry of every bundled image asset so screens never
/// hardcode raw path strings.
class AppAssets {
  AppAssets._();

  static const String _base = 'assets/images/food';

  static const String logo = '$_base/food_logo.png';
  static const String avatar = '$_base/avatar.png';
  static const String categoryType = '$_base/food_c_type.png';
  static const String fabBack = '$_base/food_ic_fab_back.png';
  static const String mapPin = '$_base/food_ic_map.png';
  static const String introPhoto = '$_base/food_ic_intro.jpg';
  static const String placeholder = '$_base/placeholder.jpg';
  static const String recipes = '$_base/recipes.png';

  // SVGs
  static const String cloche = '$_base/food_cloche.svg';
  static const String dinnerTable = '$_base/food_dinner_table.svg';
  static const String googleWallet = '$_base/food_google_wallet.svg';
  static const String compass = '$_base/food_ic_comass.svg';
  static const String delivery = '$_base/food_ic_delivery.svg';
  static const String facebook = '$_base/food_ic_fb.svg';
  static const String googleFill = '$_base/food_ic_google_fill.svg';
  static const String table = '$_base/food_ic_table.svg';
  static const String walk1 = '$_base/food_ic_walk1.svg';
  static const String walk2 = '$_base/food_ic_walk2.svg';
  static const String walk3 = '$_base/food_ic_walk3.svg';
  static const String whatsapp = '$_base/food_whatsapp.svg';
}
