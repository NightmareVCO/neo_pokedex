import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors_bg.dart';

class CircleBackGround extends StatelessWidget {
  final List<String> types;
  const CircleBackGround({super.key, required this.types});

  @override
  Widget build(BuildContext context) {
    List<Color> colors =
        types.map((type) => pokemonTypeColorsBg[type] ?? Colors.grey).toList();

    if (colors.length == 1) {
      colors = [colors.first, colors.first];
    }

    return Positioned(
      top: -210,
      right: -100,
      child: Container(
        width: 600,
        height: 600,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
