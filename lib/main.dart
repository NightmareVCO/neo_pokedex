import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:neo_pokedex/core/routes/routes.dart';
import 'package:neo_pokedex/ui/pages/home_pokemon_list.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final client = initializeClient();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MainApp(client: client));
  });
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
