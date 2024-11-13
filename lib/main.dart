import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:neo_pokedex/ui/pages/page_pokemon_details.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final client = initializeClient();
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

