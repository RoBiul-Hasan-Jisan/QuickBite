import 'package:flutter/widgets.dart';

/// Tracks favorited dishes by id. There's only one restaurant in this
/// app, so favorites are dish-level only.
class FavoritesModel extends ChangeNotifier {
  final Set<String> _dishIds = {};

  bool isDishFavorite(String id) => _dishIds.contains(id);

  Set<String> get dishIds => Set.unmodifiable(_dishIds);

  void toggleDish(String id) {
    if (!_dishIds.remove(id)) {
      _dishIds.add(id);
    }
    notifyListeners();
  }
}

class FavoritesScope extends InheritedNotifier<FavoritesModel> {
  const FavoritesScope({
    super.key,
    required FavoritesModel favorites,
    required super.child,
  }) : super(notifier: favorites);

  static FavoritesModel of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<FavoritesScope>();
    assert(scope != null, 'No FavoritesScope found in context');
    return scope!.notifier!;
  }
}
