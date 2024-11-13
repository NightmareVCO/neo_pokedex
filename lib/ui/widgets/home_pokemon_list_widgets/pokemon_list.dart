import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/widgets/home_pokemon_list_widgets/pokemon_list_card.dart';
import 'package:neo_pokedex/core/models/pokemon.dart';

class PokemonList extends StatelessWidget {
  final List<Pokemon> pokemons;

  const PokemonList({super.key, required this.pokemons});

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
            return PokemonCard(
              pokemon: pokemon,
            );
          },
        ),
      ),
    );
  }
}
