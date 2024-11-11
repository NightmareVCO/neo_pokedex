import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_evolution_tab_info_dto.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors_bg.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_icons.dart';

class PokemonEvolutionFormsText extends StatelessWidget {
  const PokemonEvolutionFormsText({
    super.key,
    required this.pokemonEvolutionTextDto,
  });

  final List<PokemonEvolutionTextDto> pokemonEvolutionTextDto;

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
                  width: 125,
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
                      'Evolution Forms',
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

              // Cadena de evoluciones
              _buildEvolutionChain(),
            ],
          )),
    );
  }

  /// Construye la cadena de evoluciones en un diseño horizontal
  Widget _buildEvolutionChain() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: _buildEvolutionWidgets(),
        ),
      ),
    );
  }

  /// Construye la lista de widgets para cada etapa de evolución
  List<Widget> _buildEvolutionWidgets() {
    List<Widget> widgets = [];

    for (int i = 0; i < pokemonEvolutionTextDto.length; i++) {
      final evolution = pokemonEvolutionTextDto[i];

      widgets.add(Padding(
        padding: const EdgeInsets.only(
          right: 16.0,
          left: 16,
        ),
        child: Container(
          width: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color:
                    pokemonTypeColors[evolution.types.first]!.withOpacity(0.5),
                blurRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network(
                  evolution.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                ),
                Text(
                  'Lv. ${evolution.level}',
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
                      child: Expanded(
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
                              Icon(
                                pokemonTypeIcons[type.toLowerCase()],
                                color: Colors.white,
                                size: 16,
                              ),
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
                      )),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ));
    }

    return widgets;
  }
}