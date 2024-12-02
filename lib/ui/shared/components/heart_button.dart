import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:neo_pokedex/ui/shared/components/favorites_notifier.dart'; // Import the global notifier

class HeartIconButton extends StatelessWidget {
  // Changed to StatelessWidget
  final Color color;
  final String pokemonRef;

  const HeartIconButton({
    super.key,
    required this.color,
    required this.pokemonRef,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: favoritesNotifier,
      builder: (context, favorites, _) {
        final isFavorited = favorites.contains(pokemonRef);
        return IconButton(
          icon: Icon(
            isFavorited ? Icons.favorite : Icons.favorite_border,
            color: isFavorited ? Colors.red : color,
            size: 30,
          ),
          onPressed: () async {
            List<String> updatedFavorites = List.from(favorites);
            if (isFavorited) {
              updatedFavorites.remove(pokemonRef);
            } else {
              updatedFavorites.add(pokemonRef);
            }
            favoritesNotifier.value =
                updatedFavorites; // Update global notifier

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setStringList(
                'favorites', updatedFavorites); // Persist changes
          },
        );
      },
    );
  }
}
