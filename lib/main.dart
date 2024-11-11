import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:neo_pokedex/ui/pages/home_pokemon_list.dart';
import 'package:neo_pokedex/ui/pages/page_pokemon_details.dart';
import 'package:neo_pokedex/ui/widgets/home_pokemon_list_widgets/pokemon_list.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final client = initializeClient();
  runApp(MainApp(client: client));
}

//TODO: Aquí deberiamos inicializar el Provider de graphql.

class MainApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  const MainApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: const MaterialApp(
        title: 'Neo Pokedex',
        home: PokemonListPage(),
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

