import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/themes/pokemon_habitat_icons.dart';
import 'package:neo_pokedex/utils/text_utils.dart';

class PokemonNumber extends StatelessWidget {
  final String number;
  final String habitat;
  const PokemonNumber({super.key, required this.number, required this.habitat});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Alinea horizontalmente al inicio
          crossAxisAlignment:
              CrossAxisAlignment.center, // Alinea verticalmente al centro
          children: [
            Text(
              '# $number',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 5),
            const Text(
              "-",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              toTitleCase(habitat),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 5),
            Icon(
              pokemonHabitatIcons[habitat],
              size: 20,
              color: Colors.white,
            ),
          ],
        ));
  }
}
