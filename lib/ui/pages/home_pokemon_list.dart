import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/shared/widgets/pokeball_barkground.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:neo_pokedex/core/services/graph_ql_service.dart';
import 'package:neo_pokedex/core/models/pokemon.dart' as models;
import 'package:neo_pokedex/ui/themes/pokeball_background_colors.dart';
import 'package:neo_pokedex/ui/widgets/home_pokemon_list_widgets/pokemon_list.dart';
import 'package:neo_pokedex/ui/widgets/home_pokemon_list_widgets/pokemon_list_app_bar.dart';

class PokemonListPage extends StatefulWidget {
  static const String routeName = '/';

  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  late final GraphQLClient _client;
  late final GraphQLService _graphQLService;
  late Future<List<models.Pokemon>> _pokemonFuture;
  //late Future<models.Pokemon> _pokemonFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _client = GraphQLProvider.of(context).value;
    _graphQLService = GraphQLService(_client);

    // Realiza la consulta para obtener los datos del Pokémon con ID específico
   // _pokemonFuture = _graphQLService.getPokemonById(1); // Cambia el ID según sea necesario
    _pokemonFuture = _graphQLService.getPokemons(); 
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<models.Pokemon>>(
    //return FutureBuilder<models.Pokemon>(
      future: _pokemonFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No Pokémon found'));
        } else {
          return Stack(
            children: [
              Scaffold(
                extendBodyBehindAppBar: true,
                backgroundColor: Colors.white,
                appBar: const PokemonListAppBar(),
                //body: PokemonList(pokemons: [snapshot.data!]),
                body: PokemonList(pokemons: snapshot.data!),
              ),
              const Positioned(
                top: 40,
                right: 10,
                child: PokeballBackground(color: PokeballBackgroundColors.black),
              ),
            ],
          );
        }
      },
    );
  }
}