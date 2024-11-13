import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:neo_pokedex/core/routes/routes.dart';
import 'package:neo_pokedex/ui/pages/home_pokemon_list.dart';
import 'package:neo_pokedex/core/models/pokemon_mega_evolutions.dart';
import 'package:neo_pokedex/core/services/graph_ql_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final client = initializeClient();
  final service = GraphQLService(client.value);
  service.getMegaEvolution(6);
  runApp(MainApp(client: client));
}

//Aquí deberiamos inicializar el Provider de graphql.

class MainApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  const MainApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Neo Pokedex',
        routes: routes,
        initialRoute: PokemonListPage.routeName,
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
