class PokemonHero {
  final int id;
  final String name;
  final String habitat;
  final List<String> types;
  final String imageUrl;
  final String cryUrl; // Added the cryUrl field

  PokemonHero({
    required this.id,
    required this.name,
    required this.habitat,
    required this.types,
    required this.imageUrl,
    required this.cryUrl, // Added to the constructor
  });

  // Parse JSON
  factory PokemonHero.fromJson(Map<String, dynamic> json) {
    return PokemonHero(
      id: json['id'],
      name: json['name'],
      habitat: json['pokemon_v2_pokemonspecy']['habitat']['name'] ?? 'unknown',
      types: (json['pokemon_v2_pokemontypes'] as List)
          .map((type) => type['pokemon_v2_type']['name'] as String)
          .toList(),
      imageUrl: json['pokemon_v2_pokemonsprites'][0]['sprites'] ?? '',
      cryUrl: json['pokemon_v2_pokemonspecy']['cryUrl'] ?? '', // Added to fromJson
    );
  }
}