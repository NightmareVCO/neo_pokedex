class PokemonStats {
  final String statValue;
  final String statName;
  final String pokemonName;

  PokemonStats(
      {required this.statValue,
      required this.statName,
      required this.pokemonName});

  factory PokemonStats.fromJson(Map<String, dynamic> json) {
    return PokemonStats(
      statValue: json['base_stat'].toString(),
      statName: json['pokemon_v2_stat']['name'],
      pokemonName: json['pokemon_v2_pokemon']['name'],
    );
  }
}
