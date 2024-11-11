import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_about_tab_info_dto.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';

class PokemonBreedingText extends StatelessWidget {
  const PokemonBreedingText({super.key, required this.pokemonBreedingTextDto});

  final PokemonBreedingTextDto pokemonBreedingTextDto;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: pokemonTypeColors[pokemonBreedingTextDto.type],
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
                        color: pokemonTypeColors[pokemonBreedingTextDto.type]!
                            .withOpacity(0.5),
                        blurRadius: 2,
                      ),
                    ],
                    color: Colors.white, // Hollow center
                    border: Border.all(
                      color: pokemonTypeColors[
                          pokemonBreedingTextDto.type]!, // Border color
                      width: 2.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'Breeding',
                      style: TextStyle(
                        color: pokemonTypeColors[
                            pokemonBreedingTextDto.type], // Text color
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Egg Group',
                            style: TextStyle(
                              color: pokemonTypeColors[
                                  pokemonBreedingTextDto.type],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            pokemonBreedingTextDto.eggGroups.join(', '),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Egg Cycle',
                            style: TextStyle(
                              color: pokemonTypeColors[
                                  pokemonBreedingTextDto.type],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            '${pokemonBreedingTextDto.eggCycle} cycles - (${pokemonBreedingTextDto.eggCycle * 257}) steps',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
