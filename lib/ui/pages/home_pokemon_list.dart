import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/shared/widgets/pokeball_barkground.dart';
import 'package:neo_pokedex/ui/themes/pokeball_background_colors.dart';
import 'package:neo_pokedex/ui/widgets/home_pokemon_list_widgets/pokemon_list.dart';
import 'package:neo_pokedex/ui/widgets/home_pokemon_list_widgets/pokemon_list_app_bar.dart';

class PokemonListPage extends StatefulWidget {
  static const String routeName = '/';

  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

//TODO: Aquí se puede pedir los pokemones con graphql
class _PokemonListPageState extends State<PokemonListPage> {
  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: PokemonListAppBar(),
          body: PokemonList(),
        ),
        Positioned(
          top: 40,
          right: 10,
          child: PokeballBackground(color: PokeballBackgroundColors.black),
        ),
      ],
    );
  }
}
