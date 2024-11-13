import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_about_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_evolution_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_moves_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_stats_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/pokemon_hero.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_image.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_name.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_number.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tabs_info.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_types.dart';
import 'package:neo_pokedex/utils/text_utils.dart';

class Pokemon extends StatelessWidget {
  const Pokemon({
    super.key,
    required this.pokemonHero,
    required this.pokemonAboutTabInfoDto,
    required this.pokemonStatsTabInfoDto,
    required this.pokemonMovesTabInfoDto,
    required this.pokemonEvolutionTabInfoDto,
  });

  final PokemonHero pokemonHero;
  final PokemonAboutTabInfoDto pokemonAboutTabInfoDto;
  final PokemonStatsTabInfoDto pokemonStatsTabInfoDto;
  final PokemonMovesTabInfoDto pokemonMovesTabInfoDto;
  final PokemonEvolutionTabInfoDto pokemonEvolutionTabInfoDto;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PokemonNumber(
              number: pokemonHero.id.toString(), habitat: pokemonHero.habitat),
          PokemonName(name: toTitleCaseWithSpaces(pokemonHero.name)),
          PokemonTypes(types: pokemonHero.types),
          PokemonImage(
            cryUrl: pokemonHero.cryUrl,
            imageUrl: pokemonHero.imageUrl,
            id: pokemonHero.id.toString(),
          ),
          const SizedBox(height: 10),
          PokemonTabsInfo(
            originId: pokemonHero.id,
            pokemonAboutTabInfoDto: pokemonAboutTabInfoDto,
            pokemonStatsTabInfoDto: pokemonStatsTabInfoDto,
            pokemonMovesTabInfoDto: pokemonMovesTabInfoDto,
            pokemonEvolutionTabInfoDto: pokemonEvolutionTabInfoDto,
          ),
        ],
      ),
    );
  }
}
