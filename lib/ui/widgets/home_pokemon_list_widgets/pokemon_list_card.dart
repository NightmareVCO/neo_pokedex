import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/shared/components/heart_button.dart';
import 'package:neo_pokedex/ui/shared/widgets/pokeball_barkground.dart';
import 'package:neo_pokedex/ui/themes/pokeball_background_colors.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors_bg.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_icons.dart';

class PokemonCard extends StatelessWidget {
  //TODO: Esto deberia recibir el objeto del pokemon como tal
  const PokemonCard(
      {super.key,
      required this.color,
      required this.imageUrl,
      required this.name,
      required this.number,
      required this.types});

  final Color color;
  final String imageUrl;
  final String name;
  final String number;
  final List<String> types;

  @override
  Widget build(BuildContext context) {
    List<Color> colors =
        types.map((type) => pokemonTypeColorsBg[type] ?? Colors.grey).toList();

    if (colors.length == 1) {
      colors = [colors.first, colors.first];
    }

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/pokemon_page'),
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
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            //like button
            const Positioned(
                top: 10, right: 0, child: HeartIconButton(color: Colors.white)),
            Positioned(
              top: 10,
              left: 15,
              child: Text(
                '# $number',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
            ),
            Positioned(
              top: 25,
              left: 15,
              child: Text(
                name,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ),
            Positioned(
              bottom: 35,
              left: 15,
              child: Column(
                children: types
                    .map((type) => Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          color: pokemonTypeColorsBg[type],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child:
                            Icon(pokemonTypeIcons[type], color: Colors.white)))
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
                      tag: number,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(imageUrl, scale: 2),
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
