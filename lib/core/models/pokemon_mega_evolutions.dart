class Mega {
  final String id;
  final String name;
  final String sprite;
  final List<String> types;

  Mega({
    required this.id,
    required this.name,
    required this.sprite,
    required this.types,
  });

  factory Mega.fromJson(Map<String, dynamic> json) {
    return Mega(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unknown',
      sprite: json['pokemon_v2_pokemonsprites'][0]['sprites'],
      types: (json['pokemon_v2_pokemontypes'] as List)
          .map((type) => type['pokemon_v2_type']['name'] as String)
          .toList(),
    );
  }
}
