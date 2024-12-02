import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_about_tab_info_dto.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';

class PokemonFlavourText extends StatelessWidget {
  const PokemonFlavourText({super.key, required this.pokemonFlavourTextDto});

  final PokemonFlavourTextDto pokemonFlavourTextDto;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: pokemonTypeColors[pokemonFlavourTextDto.type],
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
                      color: pokemonTypeColors[pokemonFlavourTextDto.type]!
                          .withOpacity(0.5),
                      blurRadius: 2,
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: pokemonTypeColors[pokemonFlavourTextDto.type]!,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    'Description',
                    style: TextStyle(
                      color: pokemonTypeColors[pokemonFlavourTextDto.type],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              pokemonFlavourTextDto.about,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
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
                    Text(
                      '${pokemonFlavourTextDto.height} m',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: VerticalDivider(
                    color: pokemonTypeColors[pokemonFlavourTextDto.type],
                    thickness: 1,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.monitor_weight_outlined),
                    Text('${pokemonFlavourTextDto.weight} kg'),
                  ],
                ),
                SizedBox(
                  height: 50,
                  child: VerticalDivider(
                    color: pokemonTypeColors[pokemonFlavourTextDto.type],
                    thickness: 1,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star),
                    Text(pokemonFlavourTextDto.captureRate),
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
