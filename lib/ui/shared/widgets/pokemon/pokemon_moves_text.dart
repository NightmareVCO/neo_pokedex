import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_moves_tab_info_dto.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_icons.dart';

class PokemonMovesText extends StatelessWidget {
  const PokemonMovesText({
    super.key,
    required this.pokemonMovesTabInfoDto,
  });

  final PokemonMovesTabInfoDto pokemonMovesTabInfoDto;

  @override
  Widget build(BuildContext context) {
    final String type = pokemonMovesTabInfoDto.type;

    return SizedBox(
      height: 630,
      child: Card(
        color: Colors.white,
        shadowColor: pokemonTypeColors[type],
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // More rounded design
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Title "Moves"
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
                      'Moves',
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
              // Table with horizontal and vertical scroll
              Expanded(
                child: SingleChildScrollView(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor: WidgetStateProperty.resolveWith(
                        (states) => pokemonTypeColors[type]!.withOpacity(0.2),
                      ),
                      dataRowMinHeight: 60,
                      dataRowMaxHeight: 60,
                      columns: const [
                        DataColumn(label: Text('Level')),
                        DataColumn(label: Text('Move')),
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('Power')),
                        DataColumn(label: Text('Accuracy')),
                        DataColumn(label: Text('PP')),
                        DataColumn(label: Text('Method')),
                        DataColumn(label: Text('Class')),
                      ],
                      rows: pokemonMovesTabInfoDto.moves.map((move) {
                        final Color moveTypeColor =
                            pokemonTypeColors[move.moveType.toLowerCase()] ??
                                Colors.grey;
                        return DataRow(cells: [
                          DataCell(Text(move.level)),
                          DataCell(Text(move.move)),
                          DataCell(
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                  color: moveTypeColor,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: getPokemonTypeIcon(move.moveType,
                                    size: 20,
                                    color: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn))),
                          ),
                          DataCell(Text(move.movePower)),
                          DataCell(Text(move.moveAccuracy)),
                          DataCell(Text(move.movePP)),
                          DataCell(Text(move.method)),
                          DataCell(Text(move.moveDamageClass)),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
