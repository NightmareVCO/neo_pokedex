class Pokemon {
  final int id;
  final String name;
  final List<String> types;
  final String imageUrl;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      types: (json['pokemon_v2_pokemontypes'] as List?)
              ?.map((type) => type['pokemon_v2_type']['name'] as String)
              .toList() ??
          [],
      imageUrl: (json['pokemon_v2_pokemonsprites'] as List?)
                  ?.isNotEmpty == true
              ? json['pokemon_v2_pokemonsprites'][0]['sprites'] ?? ''
              : '',
    );
  }
}