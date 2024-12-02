import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/pages/home_pokemon_list.dart';
import 'package:neo_pokedex/ui/pages/page_pokemon_details.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  //PokemonListPage.routeName: (_) => const PokemonListPage(),
  PokemonPage.routeName: (_) => const PokemonPage(),
};
