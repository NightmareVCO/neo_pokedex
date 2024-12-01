import 'package:neo_pokedex/core/models/pokemon_about_description.dart';
import 'package:neo_pokedex/core/models/pokemon_breeding.dart';
import 'package:neo_pokedex/core/models/pokemon_egg_group.dart';
import 'package:neo_pokedex/utils/text_utils.dart';

class PokemonAboutTabInfoDto {
  final String type;
  final PokemonFlavourTextDto pokemonFlavourTextDto;
  final PokemonInformationTextDto pokemonInformationTextDto;
  final PokemonBreedingTextDto pokemonBreedingTextDto;

  PokemonAboutTabInfoDto({
    required this.type,
    required this.pokemonFlavourTextDto,
    required this.pokemonInformationTextDto,
    required this.pokemonBreedingTextDto,
  });
}

class PokemonFlavourTextDto {
  final String type;
  final String about;
  final String captureRate;
  final String height;
  final String weight;

  PokemonFlavourTextDto({
    required this.type,
    required this.about,
    required this.captureRate,
    required this.height,
    required this.weight,
  });

  static PokemonFlavourTextDto fromJson(Map<String, dynamic> json) {
    return PokemonFlavourTextDto(
      type: json['type'],
      about: json['about'],
      captureRate: json['captureRate'],
      height: json['height'],
      weight: json['weight'],
    );
  }

  static PokemonFlavourTextDto fromAbout(
      String type, PokemonAboutDescription about) {
    return PokemonFlavourTextDto(
      type: type,
      about: removeNewLines(about.description),
      captureRate: about.captureRate.toString(),
      height: about.height.toString(),
      weight: about.weight.toString(),
    );
  }
}

class PokemonInformationTextDto {
  final String type;
  final String baseExperience;
  final String growthRate;
  final String shape;
  final String isLegendary;
  final String isMythical;

  PokemonInformationTextDto({
    required this.type,
    required this.baseExperience,
    required this.growthRate,
    required this.shape,
    required this.isLegendary,
    required this.isMythical,
  });

  static PokemonInformationTextDto fromJson(Map<String, dynamic> json) {
    return PokemonInformationTextDto(
      type: json['type'],
      baseExperience: json['baseExperience'],
      growthRate: json['growthRate'],
      shape: json['shape'],
      isLegendary: json['isLegendary'],
      isMythical: json['isMythical'],
    );
  }

  static PokemonInformationTextDto fromBreeding(
      String type, Breeding breeding) {
    return PokemonInformationTextDto(
      type: type,
      baseExperience: breeding.pokemons.first.baseExperience.toString(),
      growthRate: breeding.growthRate,
      shape: breeding.shape,
      isLegendary: breeding.isLegendary ? "Is legendary" : "Is not legendary",
      isMythical: breeding.isMythical ? "Is mythical" : "Is not mythical",
    );
  }
}

class PokemonBreedingTextDto {
  final String type;
  final int eggCycle;
  final List<String> eggGroups;

  PokemonBreedingTextDto({
    required this.type,
    required this.eggCycle,
    required this.eggGroups,
  });

  static PokemonBreedingTextDto fromJson(Map<String, dynamic> json) {
    return PokemonBreedingTextDto(
      type: json['type'],
      eggCycle: json['eggCycle'],
      eggGroups: List<String>.from(json['eggGroups']),
    );
  }

  static PokemonBreedingTextDto fromBreeding(
      String type, Breeding breeding, List<EggGroup> eggGroups) {
    return PokemonBreedingTextDto(
      type: type,
      eggCycle: breeding.hatchCounter,
      eggGroups: eggGroups.map((e) => toTitleCase(e.eggGroupName)).toList(),
    );
  }
}
