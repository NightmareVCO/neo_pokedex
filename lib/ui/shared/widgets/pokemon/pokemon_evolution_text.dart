import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_evolution_tab_info_dto.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors_bg.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_icons.dart';
import 'package:neo_pokedex/utils/pokemon_utils.dart';

class PokemonEvolutionText extends StatelessWidget {
  const PokemonEvolutionText(
      {super.key,
      required this.pokemonEvolutionTextDto,
      required this.originId});

  final List<PokemonEvolutionTextDto> pokemonEvolutionTextDto;
  final int originId;

  @override
  Widget build(BuildContext context) {
    //if have more than 1 type and the first type is normal, then use the second type
    final type = pokemonEvolutionTextDto.first.type;

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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                        fontSize: 14,
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Center(child: _buildEvolutionLayout(context)),
      ),
    );
  }

  Widget _buildEvolutionLayout(BuildContext context) {
    final totalEvolutions = pokemonEvolutionTextDto.length;

    if (totalEvolutions == 3 &&
        _hasNoEvolutionDetails(pokemonEvolutionTextDto[2])) {
      return _buildThreeEvolutionsSpecialLayout(context);
    } else if (totalEvolutions <= 3) {
      return _buildSimpleRow(context);
    } else if (totalEvolutions == 4) {
      return _buildFourEvolutionsLayout(context);
    } else if (totalEvolutions == 5) {
      return _buildFiveEvolutionsLayout(context);
    } else {
      return _buildManyEvolutionsLayout(context);
    }
  }

  bool _hasNoEvolutionDetails(PokemonEvolutionTextDto evolution) {
    return evolution.level == 'Unknown' &&
        evolution.item == 'Unknown' &&
        evolution.happiness == 'Unknown' &&
        evolution.trigger == 'Unknown';
  }

  Widget _buildThreeEvolutionsSpecialLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildEvolutionCard(pokemonEvolutionTextDto[0], context),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(child: Icon(Icons.arrow_forward, size: 24)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEvolutionCard(pokemonEvolutionTextDto[1], context),
            const SizedBox(height: 16),
            _buildEvolutionCard(pokemonEvolutionTextDto[2], context),
          ],
        ),
      ],
    );
  }

  Widget _buildEvolutionCard(
      PokemonEvolutionTextDto evolution, BuildContext context) {
    return Container(
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
              getEvolutionText(evolution),
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            Text(
              evolution.name,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: pokemonTypeColors[evolution.types.first]),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: evolution.types.map((type) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
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
                              fontSize: 14,
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
    );
  }

  Widget _buildFourEvolutionsLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildEvolutionCard(pokemonEvolutionTextDto[0], context),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(child: Icon(Icons.arrow_forward, size: 24)),
        ),
        _buildEvolutionCard(pokemonEvolutionTextDto[1], context),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(child: Icon(Icons.arrow_forward, size: 24)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEvolutionCard(pokemonEvolutionTextDto[2], context),
            const SizedBox(height: 16),
            _buildEvolutionCard(pokemonEvolutionTextDto[3], context),
          ],
        ),
      ],
    );
  }

  Widget _buildFiveEvolutionsLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildEvolutionCard(pokemonEvolutionTextDto[0], context),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(child: Icon(Icons.arrow_forward, size: 24)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEvolutionCard(pokemonEvolutionTextDto[1], context),
            const SizedBox(height: 16),
            _buildEvolutionCard(pokemonEvolutionTextDto[3], context),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(child: Icon(Icons.arrow_forward, size: 24)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEvolutionCard(pokemonEvolutionTextDto[2], context),
            const SizedBox(height: 16),
            _buildEvolutionCard(pokemonEvolutionTextDto[4], context),
          ],
        ),
      ],
    );
  }

  Widget _buildManyEvolutionsLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: pokemonEvolutionTextDto
          .map((evolution) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildEvolutionCard(evolution, context),
              ))
          .toList(),
    );
  }

  Widget _buildSimpleRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(pokemonEvolutionTextDto.length * 2 - 1, (index) {
        if (index.isEven) {
          return _buildEvolutionCard(
              pokemonEvolutionTextDto[index ~/ 2], context);
        }
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(child: Icon(Icons.arrow_forward, size: 24)),
        );
      }),
    );
  }
}
