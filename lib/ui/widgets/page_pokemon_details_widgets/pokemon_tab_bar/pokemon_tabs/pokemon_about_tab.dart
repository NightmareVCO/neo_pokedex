import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/shared/widgets/pokemon/pokemon_flavour_text.dart';

class PokemonAboutTab extends StatelessWidget {
  const PokemonAboutTab(
      {super.key,
      required this.about,
      required this.type,
      required this.captureRate,
      required this.height,
      required this.weight});

  final String about;
  final String type;
  final String captureRate;
  final String height;
  final String weight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PokemonFlavourText(
              about: about,
              type: type,
              captureRate: captureRate,
              height: height,
              weight: weight),
        ],
      ),
    );
  }
}
