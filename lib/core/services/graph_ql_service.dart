import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:neo_pokedex/core/models/pokemon.dart';

class GraphQLService {
  final GraphQLClient client;

  GraphQLService(this.client);

  // Metodo para obtener un pokemon especifico mediante su id
  Future<Pokemon> getPokemonById(int id) async {
    const String query = """
    query GetPokemonById(\$id: Int!) {
      pokemon_v2_pokemon(where: {id: {_eq: \$id}}) {
        id
        name
        pokemon_v2_pokemonspecy {
          habitat: pokemon_v2_pokemonhabitat {
            name
          }
        }
        pokemon_v2_pokemontypes {
          pokemon_v2_type {
            name
          }
        }
        pokemon_v2_pokemonsprites {
          sprites(path: "other.home.front_default")
        }
      }
    }
    """;

    final result = await client.query(
      QueryOptions(
        document: gql(query),
        variables: {'id': id},
      ),
    );

    if (result.hasException) {
      throw Exception('Error al obtener el Pokémon');
    }

    final pokemonData = result.data?['pokemon_v2_pokemon'][0];
    return Pokemon.fromJson(pokemonData);
    
  }
 

  Future<List<Pokemon>> getPokemons() async {
    const String query = '''
    query {
      pokemon_v2_pokemon {
        id
        name
        pokemon_v2_pokemontypes {
          pokemon_v2_type {
            name
          }
        }
        pokemon_v2_pokemonsprites {
          sprites(path: "other.official-artwork.front_default")
        }
      }
    }
    ''';

    final QueryOptions options = QueryOptions(document: gql(query));
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List<dynamic> data = result.data!['pokemon_v2_pokemon'];
    return data.map((json) => Pokemon.fromJson(json)).toList();
  }
}

 
