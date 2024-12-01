class PokemonHero {
  final int id;
  final String name;
  final String habitat;
  List<String> types;
  final String imageUrl;
  final String cryUrl;

  PokemonHero({
    required this.id,
    required this.name,
    required this.habitat,
    required this.types,
    required this.imageUrl,
    required this.cryUrl,
  });

  // Parse JSON
  factory PokemonHero.fromJson(Map<String, dynamic> json) {
    var pokemon = PokemonHero(
      id: json['id'],
      name: json['name'],
      habitat: json['pokemon_v2_pokemonspecy']['habitat']?['name'] ?? 'unknown',
      types: (json['pokemon_v2_pokemontypes'] as List)
          .map((type) => type['pokemon_v2_type']['name'] as String)
          .toList(),
      imageUrl: json['pokemon_v2_pokemonsprites'].isNotEmpty
          ? json['pokemon_v2_pokemonsprites'][0]['sprites'] ?? ''
          : '',
      cryUrl: json['pokemon_v2_pokemoncries'][0]['cries'] ?? '',
    );

    //if have two types and the first type is 'normal' then move it to the end
    if (pokemon.types.length == 2 && pokemon.types.first == 'normal') {
      pokemon.types = [pokemon.types[1], pokemon.types[0]];
    }

    return pokemon;
  }
}
