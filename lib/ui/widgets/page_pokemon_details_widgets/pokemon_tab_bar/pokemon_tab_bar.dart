import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tab_bar_render.dart';

class PokemonTabBar extends StatelessWidget {
  const PokemonTabBar({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        tabAlignment: TabAlignment.start,
        labelColor: Colors.white,
        dividerColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        isScrollable: true,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        unselectedLabelColor: pokemonTypeColors[type],
        unselectedLabelStyle: const TextStyle(fontSize: 16),
        indicatorColor: pokemonTypeColors[type],
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding:
            const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        indicator: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          color: pokemonTypeColors[type],
        ),
        tabs: PokemonTabBarRender(
          tabs: ["About", "Stats", "Evolution", "Moves", "Breeding"],
          type: type,
        ).renderTabs());
  }
}
