import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/routes/routes.dart';
import 'package:neo_pokedex/ui/pages/home_pokemon_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

//TODO: Aquí deberiamos inicializar el Provider de graphql.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neo Pokedex',
      routes: routes,
      initialRoute: PokemonListPage.routeName,
    );
  }
}
