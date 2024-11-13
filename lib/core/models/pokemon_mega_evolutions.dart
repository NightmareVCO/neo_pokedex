class Mega {
  final String id;
  final String name;
  final String sprite;
  final String level;
  final List<String> types;

  Mega({
    required this.id,
    required this.name,
    required this.sprite,
    required this.level,
    required this.types,
  });

  factory Mega.fromJson(Map<String, dynamic> json) {
    return Mega(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unknown',
      sprite: (json['pokemon_v2_pokemonsprites'] as List).isNotEmpty
          ? json['pokemon_v2_pokemonsprites'][0]['sprites']
          : 'Unknown',
      level: (json['pokemon_v2_pokemonspecy'] != null &&
              json['pokemon_v2_pokemonspecy']['pokemon_v2_pokemonevolutions'] != null &&
              (json['pokemon_v2_pokemonspecy']['pokemon_v2_pokemonevolutions'] as List).isNotEmpty)
          ? json['pokemon_v2_pokemonspecy']['pokemon_v2_pokemonevolutions'][0]['min_level']?.toString() ?? 'Unknown'
          : 'Unknown',
      types: (json['pokemon_v2_pokemontypes'] as List)
          .map((type) => type['pokemon_v2_type']['name'] as String)
          .toList(),
    );
  }
}