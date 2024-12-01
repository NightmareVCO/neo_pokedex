import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_dto.dart';
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
    required this.pokemonDto,
  });

  final PokemonHero pokemonHero;
  final PokemonDto pokemonDto;
  @override
  Widget build(BuildContext context) {
    void navigateToNext() {
      int nextId = int.parse(pokemonHero.id.toString()) + 1;
      Navigator.pushNamed(
        context,
        '/pokemon_page',
        arguments: nextId,
      );
    }

    void navigateToPrevious() {
      int prevId = int.parse(pokemonHero.id.toString()) - 1;
      if (prevId > 0) {
        Navigator.pushNamed(
          context,
          '/pokemon_page',
          arguments: prevId,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(
              child: Text('No hay Pokémon anterior'),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PokemonNumber(
              number: pokemonHero.id.toString(), habitat: pokemonHero.habitat),
          PokemonName(name: toTitleCaseWithSpaces(pokemonHero.name)),
          PokemonTypes(types: pokemonHero.types),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: navigateToPrevious,
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white),
              PokemonImage(
                cryUrl: pokemonHero.cryUrl,
                imageUrl: pokemonHero.imageUrl,
                id: pokemonHero.id.toString(),
              ),
              IconButton(
                  onPressed: navigateToNext,
                  icon: const Icon(Icons.arrow_forward_ios),
                  color: Colors.white),
            ],
          ),
          const SizedBox(height: 10),
          PokemonTabsInfo(
            originId: pokemonHero.id,
            pokemonDto: pokemonDto,
          ),
        ],
      ),
    );
  }
}
