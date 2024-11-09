import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/pages/page_pokemon_details.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

//TODO: Aquí deberiamos inicializar el Provider de graphql.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Neo Pokedex',
      home: PokemonPage(),
    );
  }
}
