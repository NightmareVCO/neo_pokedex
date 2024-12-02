class Pokemon {
  final int id;
  final String name;
  List<String> types;
  final String imageUrl;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    var pokemon = Pokemon(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      types: (json['pokemon_v2_pokemontypes'] as List?)
              ?.map((type) => type['pokemon_v2_type']['name'] as String)
              .toList() ??
          [],
      imageUrl: (json['pokemon_v2_pokemonsprites'] as List?)?.isNotEmpty == true
          ? json['pokemon_v2_pokemonsprites'][0]['sprites'] ?? ''
          : '',
    );

    //if have two types and the first type is 'normal' then move it to the end
    if (pokemon.types.length == 2 && pokemon.types.first == 'normal') {
      pokemon.types = [pokemon.types[1], pokemon.types[0]];
    }

    return pokemon;
  }
}
