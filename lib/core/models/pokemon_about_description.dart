class PokemonAboutDescription {
  final int height;
  final int weight;
  final int captureRate;
  final String description;

  PokemonAboutDescription({
    required this.height,
    required this.weight,
    required this.captureRate,
    required this.description,
  });

  factory PokemonAboutDescription.fromJson(Map<String, dynamic> json) {
    return PokemonAboutDescription(
      height: json['height'] ?? 'Unknown',
      weight: json['weight'] ?? 'Unknown',
      captureRate: json['pokemon_v2_pokemonspecy']['capture_rate'] ?? 'Unknown',
      description: json['pokemon_v2_pokemonspecy']['pokemon_v2_pokemonspeciesflavortexts'][0]['flavor_text'] ?? 'Unknown',
    );
  }
}