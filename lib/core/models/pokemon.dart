/*class Pokemon {
  final int id;
  final String name;
  final String habitat;
  final List<String> types;
  final String imageUrl;
  final String cryUrl; // Añadido el campo cryUrl

  Pokemon({
    required this.id,
    required this.name,
    required this.habitat,
    required this.types,
    required this.imageUrl,
    required this.cryUrl, // Añadido el campo cryUrl
  });

  // Parsear JSON
  
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      habitat: json['pokemon_v2_pokemonspecy']['habitat']['name'] ?? 'unknown',
      types: (json['pokemon_v2_pokemontypes'] as List)
          .map((type) => type['pokemon_v2_type']['name'] as String)
          .toList(),
      imageUrl: json['pokemon_v2_pokemonsprites'][0]['sprites'] ?? '',
      cryUrl: json['cryUrl'] ?? '', // Añadido el campo cryUrl
    );
  }
}*/
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