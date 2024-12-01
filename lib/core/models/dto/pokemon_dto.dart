import 'package:neo_pokedex/core/models/dto/pokemon_about_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_evolution_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_moves_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_stats_tab_info_dto.dart';

class PokemonDto {
  final PokemonAboutTabInfoDto pokemonAboutTabInfoDto;
  final PokemonStatsTabInfoDto pokemonStatsTabInfoDto;
  final PokemonMovesTabInfoDto pokemonMovesTabInfoDto;
  final PokemonEvolutionTabInfoDto pokemonEvolutionTabInfoDto;

  PokemonDto({
    required this.pokemonAboutTabInfoDto,
    required this.pokemonStatsTabInfoDto,
    required this.pokemonMovesTabInfoDto,
    required this.pokemonEvolutionTabInfoDto,
  });
}
