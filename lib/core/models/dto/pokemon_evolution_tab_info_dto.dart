import 'package:neo_pokedex/core/models/pokemon_evolutions.dart';
import 'package:neo_pokedex/core/models/pokemon_mega_evolutions.dart';
import 'package:neo_pokedex/utils/text_utils.dart';

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
  final String trigger;
  final String happiness;
  final String affection;
  final String item;
  final String name;
  final String imageUrl;
  final String predecessor;
  final List<String> types;

  PokemonEvolutionTextDto({
    required this.type,
    required this.id,
    required this.text,
    required this.level,
    required this.trigger,
    required this.happiness,
    required this.affection,
    required this.item,
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
      trigger: json['trigger'],
      level: json['level'],
      happiness: json['happiness'],
      affection: json['affection'],
      item: json['item'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      predecessor: json['predecessor'],
      types: List<String>.from(json['types']),
    );
  }

  static PokemonEvolutionTextDto fromEvolution(Evolution evolution) {
    //if first type is 'normal' then use the second type
    var customType = evolution.types.first == 'normal'
        ? evolution.types.last
        : evolution.types.first;

    return PokemonEvolutionTextDto(
      type: customType,
      id: evolution.id,
      text: 'Evolves at level ${evolution.level}',
      trigger: toTitleCaseWithSpaces(evolution.trigger),
      level: evolution.level,
      happiness: evolution.happiness,
      affection: evolution.affection,
      item: toTitleCaseWithSpaces(evolution.item),
      name: toTitleCaseWithSpaces(evolution.name),
      imageUrl: evolution.sprite ?? '',
      predecessor: '',
      types: evolution.types,
    );
  }

  static PokemonEvolutionTextDto fromMegaEvolution(Mega mega) {
    //if first type is 'normal' then use the second type
    var customType =
        mega.types.first == 'normal' ? mega.types.last : mega.types.first;

    return PokemonEvolutionTextDto(
      type: customType,
      id: mega.id,
      text: 'Mega evolves',
      trigger: '',
      level: mega.level,
      happiness: '',
      affection: '',
      item: '',
      name: toTitleCaseWithSpaces(mega.name),
      imageUrl: mega.sprite,
      predecessor: '',
      types: mega.types,
    );
  }
}
