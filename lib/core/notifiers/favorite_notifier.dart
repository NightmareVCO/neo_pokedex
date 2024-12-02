import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteNotifier extends ChangeNotifier {
  List<String> _favorites = [];

  FavoriteNotifier() {
    _loadFavorites();
  }

  List<String> get favorites => _favorites;

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList('favorites') ?? [];
    notifyListeners();
  }

  Future<void> addFavorite(String pokemonRef) async {
    if (!_favorites.contains(pokemonRef)) {
      _favorites.add(pokemonRef);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favorites', _favorites);
      notifyListeners();
    }
  }

  Future<void> removeFavorite(String pokemonRef) async {
    if (_favorites.contains(pokemonRef)) {
      _favorites.remove(pokemonRef);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favorites', _favorites);
      notifyListeners();
    }
  }

  bool isFavorited(String pokemonRef) {
    return _favorites.contains(pokemonRef);
  }
}
