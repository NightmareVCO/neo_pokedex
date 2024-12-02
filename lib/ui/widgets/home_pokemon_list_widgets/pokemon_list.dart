import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/widgets/home_pokemon_list_widgets/pokemon_list_card.dart';
import 'package:neo_pokedex/core/models/pokemon.dart';

class PokemonList extends StatelessWidget {
  final List<Pokemon> pokemons;
  final List<String> favorites; // Add this line

  const PokemonList({
    super.key,
    required this.pokemons,
    required this.favorites, // Modify constructor
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: GridView.builder(
          itemCount: pokemons.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1,
          ),
          itemBuilder: (_, index) {
            final pokemon = pokemons[index];
            final isFavorited = favorites
                .contains(pokemon.id.toString()); // Determine favorite status
            return PokemonCard(
              pokemon: pokemon,
              isFavorited: isFavorited, // Pass favorite status to PokemonCard
            );
          },
        ),
      ),
    );
  }
}
