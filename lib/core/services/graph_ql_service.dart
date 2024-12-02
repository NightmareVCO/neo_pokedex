import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:neo_pokedex/core/models/pokemon.dart';
import 'package:neo_pokedex/core/models/pokemon_about_description.dart';
import 'package:neo_pokedex/core/models/pokemon_evolutions.dart';
import 'package:neo_pokedex/core/models/pokemon_hero.dart';
import 'package:neo_pokedex/core/models/pokemon_stats.dart';
import 'package:neo_pokedex/core/models/pokemon_types.dart';
import 'package:neo_pokedex/core/models/pokemon_moves.dart';
import 'package:neo_pokedex/core/models/pokemon_egg_group.dart';
import 'package:neo_pokedex/core/models/pokemon_breeding.dart';
import 'package:neo_pokedex/core/models/pokemon_mega_evolutions.dart';

class GraphQLService {
  final GraphQLClient client;

  GraphQLService(this.client);

  // Metodo para obtener un pokemon especifico mediante su id
  Future<PokemonHero> getPokemonById(int id) async {
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
        pokemon_v2_pokemoncries {
        cries(path: "latest")
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
    return PokemonHero.fromJson(pokemonData);
  }

  Future<PokemonAboutDescription> getDescription(int pokemonId) async {
    const String query = '''
      query MyQuery(\$pokemonId: Int!) {
        pokemon_v2_pokemon(where: {id: {_eq: \$pokemonId}}) {
          height
          weight
          pokemon_v2_pokemonspecy {
            capture_rate
            pokemon_v2_pokemonspeciesflavortexts(where: {pokemon_v2_language: {name: {_eq: "en"}}},limit: 1) {
              flavor_text
            }
          }
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {'pokemonId': pokemonId},
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data!['pokemon_v2_pokemon'][0];
    return PokemonAboutDescription.fromJson(data);
  }

  // Future<List<Pokemon>> getPokemons() async {
  //   const String query = '''
  //   query {
  //     pokemon_v2_pokemon {
  //       id
  //       name
  //       pokemon_v2_pokemontypes {
  //         pokemon_v2_type {
  //           name
  //         }
  //       }
  //       pokemon_v2_pokemonsprites {
  //         sprites(path: "other.official-artwork.front_default")
  //       }
  //     }
  //   }
  //   ''';

  //   final QueryOptions options = QueryOptions(document: gql(query));
  //   final QueryResult result = await client.query(options);

  //   if (result.hasException) {
  //     throw Exception(result.exception.toString());
  //   }

  //   final List<dynamic> data = result.data!['pokemon_v2_pokemon'];
  //   return data.map((json) => Pokemon.fromJson(json)).toList();
  // }

  Future<PokemonType> getPokemonTypeById(int pokemonId) async {
    const String query = '''
   query GetPokemonTypeById(\$pokemonId: Int!) {
    pokemon_v2_pokemontype(where: {pokemon_id: {_eq: \$pokemonId}}) {
      pokemon_v2_type {
        name
      }
    }
  }
  ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {'pokemonId': pokemonId},
    );
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    if (result.data!['pokemon_v2_pokemontype'].isEmpty) {
      throw Exception('No type found for the given Pokemon ID');
    }

    if (result.data!['pokemon_v2_pokemontype'].length > 1 &&
        result.data!['pokemon_v2_pokemontype'][0]['pokemon_v2_type']['name'] ==
            'normal') {
      final dynamic data =
          result.data!['pokemon_v2_pokemontype'][1]['pokemon_v2_type'];
      return PokemonType.fromJson(data);
    }

    final dynamic data =
        result.data!['pokemon_v2_pokemontype'][0]['pokemon_v2_type'];
    return PokemonType.fromJson(data);
  }

  Future<List<PokemonStats>> getPokemonStatsById(int pokemonId) async {
    const String query = '''
    query GetPokemonStatsById(\$pokemonId: Int!) {
      pokemon_v2_pokemonstat(where: {pokemon_id: {_eq: \$pokemonId}}) {
        base_stat
        pokemon_v2_stat {
          name
        }
        pokemon_v2_pokemon {
          name
        }
      }
    }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {'pokemonId': pokemonId},
    );
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List<dynamic> data = result.data!['pokemon_v2_pokemonstat'];
    return data.map((json) => PokemonStats.fromJson(json)).toList();
  }

  Future<List<PokemonMove>> fetchPokemonMoves(int pokemonId,
      {int amountOfMoves = 1000}) async {
    const String query = '''
      query MyQuery(\$pokemonId: Int!, \$limit: Int) {
        pokemon_v2_pokemonmove(where: {pokemon_id: {_eq: \$pokemonId}}, limit: \$limit, order_by: {level: asc}) {
          level
          pokemon_v2_movelearnmethod {
            name
          }
          pokemon_v2_move {
            id
            name
            power
            accuracy
            pp
            pokemon_v2_movedamageclass {
              name
            }
            pokemon_v2_type {
              name
            }
            pokemon_v2_moveflavortexts(where: {language_id: {_eq: 9}}, limit: 1) {
              flavor_text
            }
          }
        }
      }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {'pokemonId': pokemonId, 'limit': amountOfMoves},
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List<dynamic> data = result.data!['pokemon_v2_pokemonmove'];
    final List<PokemonMove> moves =
        data.map((json) => PokemonMove.fromJson(json)).toList();

    final uniqueMoves = moves.toSet().toList();
    final uniqueMovesByName =
        {for (var move in uniqueMoves) move.move.name: move}.values.toList();
    return uniqueMovesByName;
  }

  Future<List<EggGroup>> getEggGroups(int pokemonSpeciesId) async {
    const String query = '''
    query MyQuery(\$pokemonSpeciesId: Int!) {
      pokemon_v2_pokemonegggroup(where: {pokemon_species_id: {_eq: \$pokemonSpeciesId}}) {
        pokemon_v2_egggroup {
          name
        }
        pokemon_v2_pokemonspecy {
          name
        }
      }
    }
    ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {'pokemonSpeciesId': pokemonSpeciesId},
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List<dynamic> data = result.data!['pokemon_v2_pokemonegggroup'];
    return data.map((json) => EggGroup.fromJson(json)).toList();
  }

  Future<Breeding> getBreedingData(int pokemonId) async {
    const String query = '''
    query MyQuery(\$pokemonId: Int!) {
      pokemon_v2_pokemonspecies(where: {pokemon_v2_pokemons: {id: {_eq: \$pokemonId}}}) {
        base_happiness
        gender_rate
        hatch_counter
        order
        is_legendary
        is_mythical
        pokemon_v2_growthrate {
          name
        }
        pokemon_v2_pokemonshape {
          name
        }
        pokemon_v2_pokemons {
          base_experience
          name
        }
      }
    }
  ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {'pokemonId': pokemonId},
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data!['pokemon_v2_pokemonspecies'][0];
    return Breeding.fromJson(data);
  }

  Future<List<Evolution>> getPokemonsEvolutions(int pokemonId) async {
    const String query = '''
    query MyQuery(\$pokemonId: Int) {
      pokemon_v2_pokemon(where: {id: {_eq: \$pokemonId}}) {
        pokemon_v2_pokemonspecy {
          pokemon_v2_evolutionchain {
            pokemon_v2_pokemonspecies(order_by: {order: asc}) {
              name
              id
              evolves_from_species_id
              pokemon_v2_pokemons(limit: 1) {
                pokemon_v2_pokemonsprites(limit: 1) {
                  sprites(path: "other.official-artwork.front_default")
                }
                pokemon_v2_pokemontypes {
                  pokemon_v2_type {
                    name
                  }
                }
              }
              pokemon_v2_pokemonspecies {
                pokemon_v2_pokemonevolutions {
                  pokemon_v2_evolutiontrigger {
                    name
                  }
                  min_level
                  min_happiness
                  min_affection
                  evolution_item_id
                  pokemon_v2_item {
                    id
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
      variables: {'pokemonId': pokemonId},
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data!['pokemon_v2_pokemon'];
    List<Evolution> evolutions = [];
    final species = data[0]['pokemon_v2_pokemonspecy']
        ['pokemon_v2_evolutionchain']['pokemon_v2_pokemonspecies'];

    for (int i = 0; i < species.length; i++) {
      final evo = species[i];
      Map<String, dynamic> nextEvo;

      if (i == 0) {
        nextEvo = {
          'pokemon_v2_pokemonspecies': [
            {
              'pokemon_v2_pokemonevolutions': [
                {'min_level': 1},
                {
                  'pokemon_v2_evolutiontrigger': {'name': 'level-up'}
                },
                {
                  'pokemon_v2_item': {'name': 'Unknown'}
                },
                {'min_happiness': 0},
                {'min_affection': 0}
              ]
            }
          ]
        };
      } else {
        nextEvo = species[i - 1];
      }

      evolutions.add(Evolution.fromJson([evo, nextEvo]));
    }

    return evolutions;
  }

  Future<List<Mega>> getMegaEvolution(int pokemonId) async {
    const String query = '''
  query MyQuery(\$pokemonId: Int) {
  pokemon_v2_pokemon(where: {id: {_eq: \$pokemonId}}) {
    id
    pokemon_v2_pokemonspecy {
      pokemon_v2_pokemons {
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
            pokemon_v2_pokemonspecy{
              pokemon_v2_pokemonevolutions{
                pokemon_v2_evolutiontrigger {
                    name
                }
                min_level
                min_happiness
                min_affection
                evolution_item_id
                pokemon_v2_item {
                  id
                  name
                }
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
      variables: {'pokemonId': pokemonId},
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final data = result.data!['pokemon_v2_pokemon'];
    // Lista vacia de mega
    List<Mega> megaEvolutions = [];
    for (final mega in data[0]['pokemon_v2_pokemonspecy']
        ['pokemon_v2_pokemons']) {
      megaEvolutions.add(Mega.fromJson(
          mega['pokemon_v2_pokemonforms'][0]['pokemon_v2_pokemon']));
    }
    return megaEvolutions;
  }

// FILTRADO

  Future<List<Pokemon>> getPokemons(
      List<Map<String, String>> orderBy, int limit, int offset,
      [String? search,
      List<String>? types,
      String? generation,
      String? moves,
      List<String>? ids]) async {
    String query = '''
    query MyQuery(\$where: pokemon_v2_pokemon_bool_exp, \$limit: Int, \$offset: Int, \$order: [pokemon_v2_pokemon_order_by!]) {
      pokemon_v2_pokemon(
        limit: \$limit,
        offset: \$offset,
        order_by: \$order,
        where: \$where
      ) {
        id
        name
        pokemon_v2_pokemonspecy {
          pokemon_v2_generation {
            name
          }
        }
        pokemon_v2_pokemontypes {
          pokemon_v2_type {
            name
          }
        }
        pokemon_v2_pokemonsprites {
          sprites(path: "other.official-artwork.front_default")
        }
         pokemon_v2_pokemonmoves {
          pokemon_v2_move {
            name
          }
        }
      }
    }
  ''';

    // si el filtro esta vacio se debe retornar todos los pokemones
    final where = <String, dynamic>{};

    if (search != null && search.isNotEmpty) {
      final int? searchId = int.tryParse(search);
      where['_or'] = [
        {
          'name': {'_ilike': '%$search%'}
        },
        if (searchId != null)
          {
            'id': {
              '_in': [searchId, searchId * 10, searchId * 100, searchId * 1000]
            }
          }
      ];
    }

    if (types != null && types.isNotEmpty) {
      where['pokemon_v2_pokemontypes'] = {
        'pokemon_v2_type': {
          'name': {'_in': types}
        }
      };
    }

    if (generation != null && generation.isNotEmpty) {
      where['pokemon_v2_pokemonspecy'] = {
        'pokemon_v2_generation': {
          'name': {'_eq': generation}
        }
      };
    }

    // Si la lista de ids esta vacia, que se devuelvan todos los pokemones
    if (ids != null && ids.isNotEmpty) {
      where['id'] = {'_in': ids};
    }
    if (moves != null && moves.isNotEmpty) {
      where['pokemon_v2_pokemonmoves'] = {
        'pokemon_v2_move': {
          'name': {'_eq': moves}
        }
      };
    }
    final order = <Map<String, dynamic>>[];
    for (var criterion in orderBy) {
      var field = criterion.keys.first;
      var direction = criterion.values.first;
      if (direction != 'asc' && direction != 'desc') {
        direction =
            'asc'; // Establecer 'asc' por defecto si la dirección no es válida
      }
      order.add({field: direction});
    }

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        'where': where,
        'limit': limit,
        'offset': offset,
        'order': order,
      },
    );

    final QueryResult result = await client.query(options);
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    if (result.data == null) {
      return [];
    }

    final List<dynamic> data = result.data!['pokemon_v2_pokemon'];
    if (data.isEmpty) {
      return [];
    }

    return data.map((json) => Pokemon.fromJson(json)).toList();
  }

  Future<List<PokmenonGenericMove>> fetchAllMovesPokemons(
      {int limit = 10, int offset = 10}) async {
    const String query = '''
    query GetAllMoves(\$limit: Int, \$offset: Int) {
      pokemon_v2_move(limit: \$limit, offset: \$offset, order_by: {name: asc}) {
        id
        name
      }
    }
  ''';

    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: {
        'limit': limit,
        'offset': offset,
      },
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List<dynamic> data = result.data!['pokemon_v2_move'];
    final moves =
        data.map((json) => PokmenonGenericMove.fromJson(json)).toList();

    final uniqueMoves = moves.toSet().toList();
    final uniqueMovesByName =
        {for (var move in uniqueMoves) move.name: move}.values.toList();
    return uniqueMovesByName;
  }
}
