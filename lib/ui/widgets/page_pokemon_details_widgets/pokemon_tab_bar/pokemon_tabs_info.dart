import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_about_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_evolution_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_moves_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_stats_tab_info_dto.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tab_bar.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tabs/pokemon_about_tab.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tabs/pokemon_evolution_tab.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tabs/pokemon_moves_tab.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tabs/pokemon_stats_tab.dart';

class PokemonTabsInfo extends StatelessWidget {
  const PokemonTabsInfo(
      {super.key,
      required this.pokemonAboutTabInfoDto,
      required this.pokemonStatsTabInfoDto,
      required this.pokemonMovesTabInfoDto,
      required this.pokemonEvolutionTabInfoDto});

  final PokemonAboutTabInfoDto pokemonAboutTabInfoDto;
  final PokemonStatsTabInfoDto pokemonStatsTabInfoDto;
  final PokemonMovesTabInfoDto pokemonMovesTabInfoDto;
  final PokemonEvolutionTabInfoDto pokemonEvolutionTabInfoDto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      width: double.infinity,
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            PokemonTabBar(type: pokemonAboutTabInfoDto.type),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PokemonAboutTab(
                        pokemonAboutTabInfoDto: pokemonAboutTabInfoDto),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PokemonStatsTab(
                        pokemonStatsTabInfoDto: pokemonStatsTabInfoDto,
                        pokemonTypeEffectivenessTextDto: pokemonStatsTabInfoDto
                            .pokemonTypeEffectivenessTextDto),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PokemonEvolutionTab(
                        pokemonEvolutionTabInfoDto: pokemonEvolutionTabInfoDto),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PokemonMovesTab(
                        pokemonMovesTabInfoDto: pokemonMovesTabInfoDto),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
