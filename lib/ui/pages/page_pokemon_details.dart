import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:neo_pokedex/core/services/graph_ql_service.dart';
import 'package:neo_pokedex/core/models/pokemon.dart' as models;
import 'package:neo_pokedex/ui/shared/widgets/circle_background.dart';
import 'package:neo_pokedex/ui/shared/widgets/pokeball_barkground.dart';
import 'package:neo_pokedex/ui/themes/pokeball_background_colors.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_app_bar.dart';

//TODO: Aquí tenemos que pedir la data con graphql
/*
  1. Crear una clase que se encargue de hacer la consulta a la api (core/services/graph_ql_service.dart)
  2. Crear un modelo que se encargue de parsear la data (core/models/pokemon.dart) - Usa de referencia la consulta pokemon-hero.png para saber que data necesitas
  3. Recibir el id del pokemon que se quiere mostrar en la página
  4. Hacer la consulta a la api con el id del pokemon
  5. Mostrar la data en la página
  6. Mostrar un loader mientras se carga la data (vladimir)
*/

class PokemonPage extends StatefulWidget {
  static const String routeName = '/pokemon_page';
  
  const PokemonPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  final double maxScrollOffset = 320.0;
  

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    
    
  }
  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels > maxScrollOffset) {
      _scrollController.jumpTo(maxScrollOffset);
    }

    setState(() {
      _scrollOffset = _scrollController.position.pixels > maxScrollOffset
          ? maxScrollOffset
          : _scrollController.position.pixels;
    });
  }

  // Esto es lo que hay de momento:
  final String name = "Charizard";
  final String number = "006";
  final String habitat = "forest";
  final List<String> types = ["fire", "flying"];
  final String imageUrl =
  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/6.png";
  final String cryUrl =
  "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/9.ogg";

  

  //TODO: Aquí deberiamos recibir el objeto del pokemon
  /*
    Como dije, aquí deberiamos recibir el objeto del pokemon, por ejemplo:
    final Pokemon pokemon = getPokemonById(1);

    Ese metodo deberia estar en el archivo core/services/graph_ql_pokemon.dart
    y deberia ser algo como:
    Pokemon getPokemonById(int id) {
      // Aquí deberiamos hacer la consulta a la api
    }

    La CLASE pokemon deberia tener algun metodo que se encargue de parsear la data que recibe de la api
    y deberia ser algo como:
    public static Pokemon parseJson(Map<String, dynamic> json) {
      Aquí deberiamos parsear la data
      return Pokemon(
        name: json['name'],
        number: json['number'],
        habitat: json['habitat'],
        types: json['types'],
        imageUrl: json['imageUrl'],
        cryUrl: json['cryUrl'],
      );

      Lo de arriba es solo un ejemplo, hay que ver como realmente es la data que nos llega de la api
    }

  */

  //TODO: cuando tengas eso, la idea es que pruebes cambiado el id del pokemon que quieres mostrar en la página y que se muestre la data del pokemon que corresponda (puede que haya que hacer varios cambios para lograr esto, como cambiar de stateless a stateful, etc)

  //TODO: Esto deberia recibir el objeto del pokemon como tal
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: PokemonAppBar(
            scrollOffset: _scrollOffset, type: types.first, imageUrl: imageUrl),
        // appBar: PokemonAppBar(
        // scrollOffset: _scrollOffset, type: pokemon.types.first, imageUrl: pokemon.imageUrl),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Stack(
            children: [
              CircleBackGround(types: types),
              // CircleBackGround(types: pokemon.types),
              const Positioned(
                  top: 100,
                  right: -100,
                  child: PokeballBackground(
                      color: PokeballBackgroundColors.white)),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 110),
                // child: Pokemon(pokemon: pokemon),
                child: Pokemon(
                    name: name,
                    number: number,
                    habitat: habitat,
                    types: types,
                    imageUrl: imageUrl,
                    cryUrl: cryUrl),
              ),
            ],
          ),
        ));
  }
}
