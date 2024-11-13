import 'package:neo_pokedex/core/models/pokemon_evolutions.dart';
import 'package:neo_pokedex/core/models/pokemon_mega_evolutions.dart';

class PokemonEvolutionTabInfoDto {
  final String type;
  final List<PokemonEvolutionTextDto> pokemonEvolutionTextDto;
  final List<PokemonEvolutionTextDto> pokemonMegaEvolutionTextDto;

  PokemonEvolutionTabInfoDto({
    required this.type,
    required this.pokemonEvolutionTextDto,
    required this.pokemonMegaEvolutionTextDto,
  });
}

class PokemonEvolutionTextDto {
  final String type;
  final String id;
  final String text;
  final String level;
  final String name;
  final String imageUrl;
  final String predecessor;
  final List<String> types;

  PokemonEvolutionTextDto({
    required this.type,
    required this.id,
    required this.text,
    required this.level,
    required this.name,
    required this.imageUrl,
    required this.predecessor,
    required this.types,
  });

  static PokemonEvolutionTextDto fromJson(Map<String, dynamic> json) {
    return PokemonEvolutionTextDto(
      type: json['type'],
      id: json['id'],
      text: json['text'],
      level: json['level'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      predecessor: json['predecessor'],
      types: List<String>.from(json['types']),
    );
  }

  static PokemonEvolutionTextDto fromEvolution(Evolution evolution) {
    return PokemonEvolutionTextDto(
      type: evolution.types.first,
      id: evolution.id,
      text: 'Evolves at level ${evolution.level}',
      level: evolution.level,
      name: evolution.name,
      imageUrl: evolution.sprite ?? '',
      predecessor: '', // Populate as needed
      types: evolution.types,
    );
  }

  static PokemonEvolutionTextDto fromMegaEvolution(Mega mega) {
    return PokemonEvolutionTextDto(
      type: mega.types.first,
      id: mega.id,
      text: 'Mega evolves',
      level: '', // Populate as needed
      name: mega.name,
      imageUrl: mega.sprite,
      predecessor: '', // Populate as needed
      types: mega.types,
    );
  }
}
