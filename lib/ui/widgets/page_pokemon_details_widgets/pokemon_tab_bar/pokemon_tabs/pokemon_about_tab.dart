import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_about_tab_info_dto.dart';
import 'package:neo_pokedex/ui/shared/widgets/pokemon/pokemon_breeding_text.dart';
import 'package:neo_pokedex/ui/shared/widgets/pokemon/pokemon_flavour_text.dart';
import 'package:neo_pokedex/ui/shared/widgets/pokemon/pokemon_information_text.dart';

class PokemonAboutTab extends StatelessWidget {
  const PokemonAboutTab({super.key, required this.pokemonAboutTabInfoDto});

  final PokemonAboutTabInfoDto pokemonAboutTabInfoDto;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PokemonFlavourText(
              pokemonFlavourTextDto:
                  pokemonAboutTabInfoDto.pokemonFlavourTextDto),
          const SizedBox(height: 10),
          PokemonInformationText(
              pokemonInformationTextDto:
                  pokemonAboutTabInfoDto.pokemonInformationTextDto),
          const SizedBox(height: 10),
          PokemonBreedingText(
              pokemonBreedingTextDto:
                  pokemonAboutTabInfoDto.pokemonBreedingTextDto),
        ],
      ),
    );
  }
}
