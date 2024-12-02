import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_moves_tab_info_dto.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_icons.dart';
import 'package:neo_pokedex/utils/text_utils.dart';

class PokemonMovesText extends StatelessWidget {
  const PokemonMovesText({
    super.key,
    required this.pokemonMovesTabInfoDto,
  });

  final PokemonMovesTabInfoDto pokemonMovesTabInfoDto;

  @override
  Widget build(BuildContext context) {
    final String type = pokemonMovesTabInfoDto.type;
    final List<String> methods = ['machine', 'tutor', 'egg', 'level-up'];

    return DefaultTabController(
      length: methods.length,
      child: SizedBox(
        height: 630,
        child: Card(
          color: Colors.white,
          shadowColor: pokemonTypeColors[type],
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // More rounded design
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
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
                        'Moves',
                        style: TextStyle(
                          color: pokemonTypeColors[type],
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TabBar(
                  tabAlignment: TabAlignment.center,
                  labelColor: Colors.white,
                  dividerColor: Colors.transparent,
                  splashFactory: NoSplash.splashFactory,
                  isScrollable: true,
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  unselectedLabelColor: pokemonTypeColors[type],
                  unselectedLabelStyle: const TextStyle(fontSize: 16),
                  indicatorColor: pokemonTypeColors[type],
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  indicator: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: pokemonTypeColors[type],
                  ),
                  tabs: methods
                      .map((method) => Tab(text: method.capitalize()))
                      .toList(),
                ),
                Expanded(
                  child: TabBarView(
                    children: methods.map((method) {
                      final moves = pokemonMovesTabInfoDto.moves
                          .where((move) => move.method.toLowerCase() == method)
                          .toList();

                      final uniqueMoves = {
                        for (var move in moves) move.move: move
                      }.values.toList();

                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Wrap(
                            runSpacing: 10,
                            children: uniqueMoves.map((move) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                shadowColor: pokemonTypeColors[move.moveType],
                                color: Colors.white,
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6.0, vertical: 6.0),
                                            decoration: BoxDecoration(
                                              color: pokemonTypeColors[move
                                                      .moveType
                                                      .toLowerCase()] ??
                                                  Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            child: getPokemonTypeIcon(
                                              move.moveType,
                                              size: 20,
                                              color: const ColorFilter.mode(
                                                  Colors.white,
                                                  BlendMode.srcIn),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                toTitleCaseWithSpaces(
                                                    move.move),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Text('Level: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200)),
                                                  Text(move.level,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text('Power: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(move.movePower),
                                            ],
                                          ),
                                          const SizedBox(width: 40),
                                          Row(
                                            children: [
                                              const Text('Accuracy: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(move.moveAccuracy),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Text('PP: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(move.movePP),
                                            ],
                                          ),
                                          const SizedBox(width: 64),
                                          Row(
                                            children: [
                                              const Text('Class: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(toTitleCase(
                                                  move.moveDamageClass)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      const Text("Description",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Center(
                                        child: Text(
                                          removeNewLines(move.moveFlavorText),
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
