class Evolution {
  final String name;
  final String id;
  final String? sprite;
  final String level;
  final String trigger;
  final List<String> types;

  Evolution({
    required this.name,
    required this.id,
    required this.sprite,
    required this.level,
    required this.trigger,
    required this.types,
  });

  factory Evolution.fromJson(Map<String, dynamic> json) {
    return Evolution(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? 'Unknown',
      sprite: (json['pokemon_v2_pokemons'] != null &&
              json['pokemon_v2_pokemons'].isNotEmpty &&
              json['pokemon_v2_pokemons'][0]['pokemon_v2_pokemonsprites'] !=
                  null &&
              json['pokemon_v2_pokemons'][0]['pokemon_v2_pokemonsprites']
                  .isNotEmpty)
          ? json['pokemon_v2_pokemons'][0]['pokemon_v2_pokemonsprites'][0]
              ['sprites']
          : 'Unknown',
      level: (json['pokemon_v2_pokemonspecies'] != null &&
              json['pokemon_v2_pokemonspecies'].isNotEmpty &&
              json['pokemon_v2_pokemonspecies'][0]
                      ['pokemon_v2_pokemonevolutions'] !=
                  null &&
              json['pokemon_v2_pokemonspecies'][0]
                      ['pokemon_v2_pokemonevolutions']
                  .isNotEmpty)
          ? json['pokemon_v2_pokemonspecies'][0]['pokemon_v2_pokemonevolutions']
                      [0]['min_level']
                  ?.toString() ??
              'Unknown'
          : 'Unknown',
      trigger: (json['pokemon_v2_pokemonspecies'] != null &&
              json['pokemon_v2_pokemonspecies'].isNotEmpty &&
              json['pokemon_v2_pokemonspecies'][0]
                      ['pokemon_v2_pokemonevolutions'] !=
                  null &&
              json['pokemon_v2_pokemonspecies'][0]
                      ['pokemon_v2_pokemonevolutions']
                  .isNotEmpty &&
              json['pokemon_v2_pokemonspecies'][0]
                          ['pokemon_v2_pokemonevolutions'][0]
                      ['pokemon_v2_evolutiontrigger'] !=
                  null)
          ? json['pokemon_v2_pokemonspecies'][0]['pokemon_v2_pokemonevolutions']
                  [0]['pokemon_v2_evolutiontrigger']['name'] ??
              'Unknown'
          : 'Unknown',
      types: (json['pokemon_v2_pokemons'] != null &&
              json['pokemon_v2_pokemons'].isNotEmpty &&
              json['pokemon_v2_pokemons'][0]['pokemon_v2_pokemontypes'] != null)
          ? (json['pokemon_v2_pokemons'][0]['pokemon_v2_pokemontypes'] as List)
              .map((type) => type['pokemon_v2_type']['name'] as String)
              .toList()
          : [],
    );
  }
}
