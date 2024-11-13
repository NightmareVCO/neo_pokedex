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
// imprime el json de mega
void printMega(Mega mega) {
  print('Mega Pokémon: ${mega.name}');
  print('ID: ${mega.id}');
  print('Types: ${mega.types.join(', ')}');
  print('Sprite: ${mega.sprite}');
}

/*
Future<List<Mega>> getMegaEvolution(int pokemonId) async {
  const String query = '''
  query MyQuery(\$pokemonId: Int) {
  pokemon_v2_pokemon(where: {id: {_eq: \$pokemonId}}) {
    id
    pokemon_v2_pokemonspecy {
      pokemon_v2_pokemons(where: {pokemon_v2_pokemonforms: {is_mega: {_eq: true}}}) {
        pokemon_v2_pokemonforms {
          pokemon_v2_pokemon {
            id
            name
            pokemon_v2_pokemonsprites {
              sprites(path: "other.official-artwork.front_default")
            }
            pokemon_v2_pokemontypes {
              pokemon_v2_type {
                name
              }
            }
          }
        }
      }
    }
  }
}
''';

final QueryOptions options = QueryOptions(
  document: gql(query),
  variables: {'pokemonId': pokemonId},  // pokemonId es un entero
);


  final QueryResult result = await client.query(options);

  if (result.hasException) {
    throw Exception(result.exception.toString());
  }

  final data = result.data!['pokemon_v2_pokemon'];
  print(data[0]['pokemon_v2_pokemonspecy']);
  // Lista vacia de mega
  List<Mega> megaEvolutions = [];
  for (final mega in data[0]['pokemon_v2_pokemonspecy']['pokemon_v2_pokemons']) {
    megaEvolutions.add(Mega.fromJson(mega['pokemon_v2_pokemonforms'][0]['pokemon_v2_pokemon']));
    
  }
  return megaEvolutions;
  
}

*/ 