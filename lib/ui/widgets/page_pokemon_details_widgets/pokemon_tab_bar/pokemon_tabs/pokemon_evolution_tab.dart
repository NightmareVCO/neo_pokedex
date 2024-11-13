import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_evolution_tab_info_dto.dart';
import 'package:neo_pokedex/ui/shared/widgets/pokemon/pokemon_evolution_text.dart';
import 'package:neo_pokedex/ui/shared/widgets/pokemon/pokemon_evolutions_forms_text.dart';

class PokemonEvolutionTab extends StatelessWidget {
  const PokemonEvolutionTab(
      {super.key, required this.pokemonEvolutionTabInfoDto});

  final PokemonEvolutionTabInfoDto pokemonEvolutionTabInfoDto;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PokemonEvolutionText(
              pokemonEvolutionTextDto:
                  pokemonEvolutionTabInfoDto.pokemonEvolutionTextDto),
          PokemonEvolutionFormsText(
              pokemonEvolutionTextDto:
                  pokemonEvolutionTabInfoDto.pokemonMegaEvolutionTextDto)
        ],
      ),
    );
  }
}
