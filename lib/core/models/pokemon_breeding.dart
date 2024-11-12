class Breeding {
  final int baseHappiness;
  final int genderRate;
  final int hatchCounter;
  final int order;
  final bool isLegendary;
  final bool isMythical;
  final String growthRate;
  final String shape;
  final List<PokemonSpecies> pokemons;

  Breeding({
    required this.baseHappiness,
    required this.genderRate,
    required this.hatchCounter,
    required this.order,
    required this.isLegendary,
    required this.isMythical,
    required this.growthRate,
    required this.shape,
    required this.pokemons,
  });

  factory Breeding.fromJson(Map<String, dynamic> json) {
    return Breeding(
      baseHappiness: json['base_happiness'],
      genderRate: json['gender_rate'],
      hatchCounter: json['hatch_counter'],
      order: json['order'],
      isLegendary: json['is_legendary'],
      isMythical: json['is_mythical'],
      growthRate: json['pokemon_v2_growthrate']['name'],
      shape: json['pokemon_v2_pokemonshape']['name'],
      pokemons: (json['pokemon_v2_pokemons'] as List)
          .map((pokemonJson) => PokemonSpecies.fromJson(pokemonJson))
          .toList(),
    );
  }
}

class PokemonSpecies {
  final String name;
  final int baseExperience;

  PokemonSpecies({
    required this.name,
    required this.baseExperience,
  });

  factory PokemonSpecies.fromJson(Map<String, dynamic> json) {
    return PokemonSpecies(
      name: json['name'],
      baseExperience: json['base_experience'],
    );
  }
}
