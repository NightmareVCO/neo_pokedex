import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_evolution_tab_info_dto.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors_bg.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_icons.dart';

class PokemonEvolutionText extends StatelessWidget {
  const PokemonEvolutionText(
      {super.key,
      required this.pokemonEvolutionTextDto,
      required this.originId});

  final List<PokemonEvolutionTextDto> pokemonEvolutionTextDto;
  final int originId;

  @override
  Widget build(BuildContext context) {
    final String type = pokemonEvolutionTextDto.first.type;

    return Card(
      color: Colors.white,
      shadowColor: pokemonTypeColors[type],
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
          padding: const EdgeInsets.all(19.0),
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
                    color: Colors.white,
                    border: Border.all(
                      color: pokemonTypeColors[type]!,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'Evolution',
                      style: TextStyle(
                        color: pokemonTypeColors[type],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildEvolutionChain(context),
            ],
          )),
    );
  }

  Widget _buildEvolutionChain(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: _buildEvolutionWidgets(context),
        ),
      ),
    );
  }

  List<Widget> _buildEvolutionWidgets(BuildContext context) {
    List<Widget> widgets = [];

    for (int i = 0; i < pokemonEvolutionTextDto.length; i++) {
      final evolution = pokemonEvolutionTextDto[i];

      widgets.add(Container(
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: pokemonTypeColors[evolution.types.first]!.withOpacity(0.5),
              blurRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => {
                  if (originId != int.parse(evolution.id))
                    {
                      Navigator.pushNamed(
                        context,
                        '/pokemon_page',
                        arguments: int.parse(evolution.id),
                      )
                    }
                },
                child: Image.network(
                  evolution.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                evolution.level != 'Unknown'
                    ? 'Lv. ${evolution.level}'
                    : evolution.item != 'Unknown'
                        ? 'Item: ${evolution.item}'
                        : evolution.happiness != 'Unknown'
                            ? 'Happiness: ${evolution.happiness}'
                            : evolution.trigger != 'Unknown'
                                ? evolution.trigger
                                : '',
                style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              Text(
                evolution.name,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: pokemonTypeColors[evolution.types.first]),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: evolution.types.map((type) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: pokemonTypeColorsBg[type.toLowerCase()],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getPokemonTypeIcon(type,
                                size: 12,
                                color: const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn)),
                            const SizedBox(width: 2),
                            Text(
                              type.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ));

      if (i < pokemonEvolutionTextDto.length - 1) {
        widgets.add(const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Icon(
            Icons.arrow_forward,
            size: 24,
          ),
        ));
      }
    }

    return widgets;
  }
}
