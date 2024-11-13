import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors_bg.dart';
import 'package:neo_pokedex/ui/widgets/home_pokemon_list_widgets/pokemon_list_card.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

//TODO: AQUÍ TENEMOS MÁS DE LO MISMO QUE TE EXPLICABA ANTERIORMENTE, DEBERÍAMOS RECIBIR UNA LISTA DE POKEMONES
class _PokemonListState extends State<PokemonList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1,
                ),
                itemBuilder: (_, index) => PokemonCard(
                    name: 'Charizard',
                    number: '006',
                    types: const ['fire', 'flying'],
                    imageUrl:
                        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png',
                    color: pokemonTypeColorsBg[
                        (index % 2 == 0) ? "grass" : "fire"]!),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
