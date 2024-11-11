import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_stats_tab_info_dto.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';

class PokemonStatsText extends StatelessWidget {
  const PokemonStatsText({super.key, required this.pokemonStatsTextDto});

  final PokemonStatsTextDto pokemonStatsTextDto;

  @override
  Widget build(BuildContext context) {
    StatsBuilder statsBuilder = StatsBuilder(
      type: pokemonStatsTextDto.type,
      pokemonTypeColors: pokemonTypeColors,
    );

    Map<String, double> stats = {
      'Attack': pokemonStatsTextDto.attack,
      'Defense': pokemonStatsTextDto.defense,
      'Special Attack': pokemonStatsTextDto.specialAttack,
      'Special Defense': pokemonStatsTextDto.specialDefense,
      'Speed': pokemonStatsTextDto.speed,
    };

    return Card(
      color: Colors.white,
      shadowColor: pokemonTypeColors[pokemonStatsTextDto.type],
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
                        color: pokemonTypeColors[pokemonStatsTextDto.type]!
                            .withOpacity(0.5),
                        blurRadius: 2,
                      ),
                    ],
                    color: Colors.white, // Hollow center
                    border: Border.all(
                      color: pokemonTypeColors[
                          pokemonStatsTextDto.type]!, // Border color
                      width: 2.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'Stats',
                      style: TextStyle(
                        color: pokemonTypeColors[
                            pokemonStatsTextDto.type], // Text color
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: statsBuilder.buildStatList(stats),
              )
            ],
          )),
    );
  }
}

class StatsBuilder {
  final String type;
  final Map<String, Color> pokemonTypeColors;

  StatsBuilder({
    required this.type,
    required this.pokemonTypeColors,
  });

  // Método para crear un widget de estadística individual
  Widget buildStatRow(String label, double value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: pokemonTypeColors[type],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          children: [
            // Barra de progreso lineal
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: (value / 255).clamp(0.0, 1.0),
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      pokemonTypeColors[type]!,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  // Método para generar una lista de widgets de estadísticas
  List<Widget> buildStatList(Map<String, double> stats) {
    return stats.entries.map((entry) {
      return buildStatRow(entry.key, entry.value);
    }).toList();
  }
}
