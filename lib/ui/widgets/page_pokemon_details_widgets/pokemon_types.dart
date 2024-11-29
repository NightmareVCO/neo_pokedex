import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_icons.dart';
import 'package:neo_pokedex/utils/text_utils.dart';

class PokemonTypes extends StatelessWidget {
  final List<String> types;
  const PokemonTypes({super.key, required this.types});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: types
          .map((type) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: pokemonTypeColors[type] ?? Colors.grey,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      getPokemonTypeIcon(type,
                          size: 20,
                          color: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn)),
                      const SizedBox(width: 5),
                      Text(
                        toTitleCase(type),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
