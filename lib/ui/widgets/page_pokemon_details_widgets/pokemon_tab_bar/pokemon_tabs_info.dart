import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_dto.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tab_bar.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tabs/pokemon_about_tab.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tabs/pokemon_evolution_tab.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tabs/pokemon_moves_tab.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tabs/pokemon_stats_tab.dart';

class PokemonTabsInfo extends StatelessWidget {
  const PokemonTabsInfo(
      {super.key, required this.pokemonDto, required this.originId});

  final PokemonDto pokemonDto;
  final int originId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      width: double.infinity,
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            PokemonTabBar(type: pokemonDto.pokemonAboutTabInfoDto.type),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PokemonAboutTab(
                        pokemonAboutTabInfoDto:
                            pokemonDto.pokemonAboutTabInfoDto),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PokemonStatsTab(
                        pokemonStatsTabInfoDto:
                            pokemonDto.pokemonStatsTabInfoDto,
                        pokemonTypeEffectivenessTextDto: pokemonDto
                            .pokemonStatsTabInfoDto
                            .pokemonTypeEffectivenessTextDto),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PokemonEvolutionTab(
                        pokemonEvolutionTabInfoDto:
                            pokemonDto.pokemonEvolutionTabInfoDto,
                        originId: originId),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PokemonMovesTab(
                        pokemonMovesTabInfoDto:
                            pokemonDto.pokemonMovesTabInfoDto),
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
