class PokemonStats {
  final String statName;
  final String pokemonName;

  PokemonStats({required this.statName, required this.pokemonName});

  factory PokemonStats.fromJson(Map<String, dynamic> json) {
    return PokemonStats(
      statName: json['pokemon_v2_stat']['name'],
      pokemonName: json['pokemon_v2_pokemon']['name'],
    );
  }
}