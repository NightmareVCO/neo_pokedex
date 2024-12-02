import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/pokemon.dart';
import 'package:neo_pokedex/ui/shared/components/heart_button.dart';
import 'package:neo_pokedex/ui/shared/widgets/pokeball_barkground.dart';
import 'package:neo_pokedex/ui/themes/pokeball_background_colors.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors_bg.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_icons.dart';
import 'package:neo_pokedex/utils/text_utils.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final bool isFavorited; // Add this line

  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.isFavorited, // Modify constructor
  });

  @override
  Widget build(BuildContext context) {
    List<Color> colors = pokemon.types
        .map((type) => pokemonTypeColorsBg[type] ?? Colors.grey)
        .toList();

    if (colors.length == 1) {
      colors = [colors.first, colors.first];
    }

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/pokemon_page',
        arguments: pokemon.id,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            stops: const [0.4, 0.9],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          color: pokemonTypeColorsBg[pokemon.types.first],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            // Like button with favorite status
            Positioned(
              top: -2,
              right: 0,
              child: HeartIconButton(
                pokemonRef: pokemon.id.toString(),
                color: Colors.white,
              ),
            ),
            Positioned(
              top: 10,
              left: 15,
              child: Text(
                '# ${pokemon.id.toString().padLeft(3, '0')}',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
            ),
            Positioned(
              top: 37,
              left: 15,
              child: SizedBox(
                width: 160,
                child: Text(
                  toTitleCaseWithSpaces(pokemon.name),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: pokemon.name.length >= 14
                        ? 18
                        : pokemon.name.length >= 17
                            ? 16
                            : 20,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 15,
              child: Column(
                children: pokemon.types
                    .map((type) => Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          color: pokemonTypeColorsBg[type],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: getPokemonTypeIcon(type,
                            size: 20,
                            color: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn))))
                    .toList(),
              ),
            ),
            const Positioned(
                top: 60,
                right: -10,
                child: PokeballBackground(
                    color: PokeballBackgroundColors.whiteSmall)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Hero(
                      tag: pokemon.id,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            NetworkImage(pokemon.imageUrl, scale: 2),
                      ),
                    )
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
