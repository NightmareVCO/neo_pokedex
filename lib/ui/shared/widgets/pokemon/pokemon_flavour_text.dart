import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';

class PokemonFlavourText extends StatelessWidget {
  final String about;
  final String type;
  final String captureRate;
  final String height;
  final String weight;

  const PokemonFlavourText(
      {super.key,
      required this.about,
      required this.type,
      required this.captureRate,
      required this.height,
      required this.weight});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: pokemonTypeColors[type],
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 28,
                width: 100,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: pokemonTypeColors[type]!.withOpacity(0.5),
                      blurRadius: 2,
                    ),
                  ],
                  color: Colors.white, // Hollow center
                  border: Border.all(
                    color: pokemonTypeColors[type]!, // Border color
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    'Flavour Text',
                    style: TextStyle(
                      color: pokemonTypeColors[type], // Text color
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              about,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.height),
                    Text('$height m'),
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: VerticalDivider(
                    color: pokemonTypeColors[type],
                    thickness: 1,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.monitor_weight_outlined),
                    Text('$weight kg'),
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: VerticalDivider(
                    color: pokemonTypeColors[type],
                    thickness: 1,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star),
                    Text(captureRate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
