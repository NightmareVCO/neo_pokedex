import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_stats_tab_info_dto.dart';
import 'package:neo_pokedex/ui/shared/widgets/pokemon/pokemon_effectiveness_text.dart';
import 'package:neo_pokedex/ui/shared/widgets/pokemon/pokemon_stats_text.dart';

class PokemonStatsTab extends StatelessWidget {
  const PokemonStatsTab(
      {super.key,
      required this.pokemonStatsTabInfoDto,
      required this.pokemonTypeEffectivenessTextDto});

  final PokemonStatsTabInfoDto pokemonStatsTabInfoDto;
  final PokemonTypeEffectivenessTextDto pokemonTypeEffectivenessTextDto;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PokemonStatsText(
              pokemonStatsTextDto: pokemonStatsTabInfoDto.pokemonStatsTextDto),
          PokemonEffectivenessText(
            pokemonTypeEffectivenessTextDto: pokemonTypeEffectivenessTextDto,
          ),
        ],
      ),
    );
  }
}
