import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';

class PokemonTabBarRender {
  final List<String> tabs;
  final String type;

  PokemonTabBarRender({required this.tabs, required this.type});

  List<Widget> renderTabs() {
    return tabs.asMap().entries.map((entry) {
      String tab = entry.value;
      return Tab(
        child: Container(
          height: 30,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: pokemonTypeColors[type]!, width: 2),
          ),
          child: Center(child: Text(tab)),
        ),
      );
    }).toList();
  }
}
