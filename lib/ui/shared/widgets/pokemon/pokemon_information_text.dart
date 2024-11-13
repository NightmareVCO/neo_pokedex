import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_about_tab_info_dto.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';
import 'package:neo_pokedex/utils/text_utils.dart';

class PokemonInformationText extends StatelessWidget {
  const PokemonInformationText(
      {super.key, required this.pokemonInformationTextDto});

  final PokemonInformationTextDto pokemonInformationTextDto;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: pokemonTypeColors[pokemonInformationTextDto.type],
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
                        color:
                            pokemonTypeColors[pokemonInformationTextDto.type]!
                                .withOpacity(0.5),
                        blurRadius: 2,
                      ),
                    ],
                    color: Colors.white, // Hollow center
                    border: Border.all(
                      color: pokemonTypeColors[
                          pokemonInformationTextDto.type]!, // Border color
                      width: 2.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'Information',
                      style: TextStyle(
                        color: pokemonTypeColors[
                            pokemonInformationTextDto.type], // Text color
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
                            'Base Experience',
                            style: TextStyle(
                              color: pokemonTypeColors[
                                  pokemonInformationTextDto.type],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            pokemonInformationTextDto.baseExperience,
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
                            'Growth Rate',
                            style: TextStyle(
                              color: pokemonTypeColors[
                                  pokemonInformationTextDto.type],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            toTitleCaseWithSpaces(
                                pokemonInformationTextDto.growthRate),
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
                            'Shape',
                            style: TextStyle(
                              color: pokemonTypeColors[
                                  pokemonInformationTextDto.type],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            toTitleCase(pokemonInformationTextDto.shape),
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
                            'Legendary',
                            style: TextStyle(
                              color: pokemonTypeColors[
                                  pokemonInformationTextDto.type],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            pokemonInformationTextDto.isLegendary,
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
                            'Mythical',
                            style: TextStyle(
                              color: pokemonTypeColors[
                                  pokemonInformationTextDto.type],
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            pokemonInformationTextDto.isMythical,
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
