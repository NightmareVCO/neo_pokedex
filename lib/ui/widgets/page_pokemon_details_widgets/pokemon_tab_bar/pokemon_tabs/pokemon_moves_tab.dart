import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_moves_tab_info_dto.dart';
import 'package:neo_pokedex/ui/shared/widgets/pokemon/pokemon_moves_text.dart';

class PokemonMovesTab extends StatelessWidget {
  const PokemonMovesTab({super.key, required this.pokemonMovesTabInfoDto});

  final PokemonMovesTabInfoDto pokemonMovesTabInfoDto;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PokemonMovesText(pokemonMovesTabInfoDto: pokemonMovesTabInfoDto)
        ],
      ),
    );
  }
}
