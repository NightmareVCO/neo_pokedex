import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_stats_tab_info_dto.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors_bg.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_icons.dart';

class PokemonEffectivenessText extends StatelessWidget {
  const PokemonEffectivenessText({
    super.key,
    required this.pokemonTypeEffectivenessTextDto,
  });

  final PokemonTypeEffectivenessTextDto pokemonTypeEffectivenessTextDto;

  @override
  Widget build(BuildContext context) {
    final String type = pokemonTypeEffectivenessTextDto.type;
    final List<Map<String, dynamic>> effectiveness =
        pokemonTypeEffectivenessTextDto.getEffectiveness([type]);

    return Card(
      color: Colors.white,
      shadowColor: pokemonTypeColorsBg[type],
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
                width: 150,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: pokemonTypeColorsBg[type]!.withOpacity(0.5),
                      blurRadius: 2,
                    ),
                  ],
                  color: Colors.white, // Hollow center
                  border: Border.all(
                    color: pokemonTypeColorsBg[type]!, // Border color
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    'Type Effectiveness',
                    style: TextStyle(
                      color: pokemonTypeColorsBg[type], // Text color
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildEffectivenessWrap(effectiveness),
          ],
        ),
      ),
    );
  }

  Widget _buildEffectivenessWrap(List<Map<String, dynamic>> effectiveness) {
    return Wrap(
      spacing: 30.0,
      runSpacing: 13.0,
      alignment: WrapAlignment.start,
      children: effectiveness.map((item) {
        final String type = item['type'];
        final double multiplier = item['multiplier'];
        final Color typeColor = pokemonTypeColorsBg[type.toLowerCase()] ??
            Colors.grey.withOpacity(0.7);

        return _buildEffectivenessCell(type, multiplier, typeColor);
      }).toList(),
    );
  }

  Widget _buildEffectivenessCell(
      String type, double multiplier, Color typeColor) {
    return SizedBox(
      width: 80,
      child: Row(
        children: [
          Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: typeColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: getPokemonTypeIcon(type.toLowerCase(),
                  size: 16,
                  color:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn))),
          const Spacer(),
          // Texto del multiplicador
          Text(
            'x$multiplier',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
