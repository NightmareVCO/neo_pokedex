import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:neo_pokedex/ui/pages/page_pokemon_details.dart';
import 'package:neo_pokedex/core/models/pokemon_mega_evolutions.dart';
import 'package:neo_pokedex/core/services/graph_ql_service.dart';
import 'package:neo_pokedex/core/models/pokemon_evolutions.dart';

void main() async {
  final client = initializeClient();
  final service = GraphQLService(client.value);
  final evolutionData = await service.getPokemonsEvolutions(6);
  
  print(1);
  for (final mega in evolutionData) {
    printEvolution(mega);
  } 

  runApp(MainApp(client: client));
}

class MainApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  const MainApp({super.key, required this.client});
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: const MaterialApp(
        title: 'Neo Pokedex',
        home: PokemonPage(),
      ),
    );
  }
}

ValueNotifier<GraphQLClient> initializeClient() {
  final HttpLink httpLink = HttpLink(
    'https://beta.pokeapi.co/graphql/v1beta',
  );
  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    ),
  );
  return client;
}