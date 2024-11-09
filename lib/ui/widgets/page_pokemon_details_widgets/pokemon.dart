import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_image.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_name.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_number.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tabs_info.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_types.dart';

class Pokemon extends StatelessWidget {
  const Pokemon(
      {super.key,
      required this.name,
      required this.number,
      required this.habitat,
      required this.types,
      required this.imageUrl,
      required this.cryUrl});

  //TODO: Tenemos esto pero realmente solo deberia recibir un objeto Pokemon y no todos sus atributos.
  final String name;
  final String number;
  final String habitat;
  final List<String> types;
  final String imageUrl;
  final String cryUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PokemonNumber(number: number, habitat: habitat),
        PokemonName(name: name),
        PokemonTypes(types: types),
        PokemonImage(cryUrl: cryUrl, imageUrl: imageUrl),
        const SizedBox(height: 10),
        SizedBox(height: 1000, child: PokemonTabsInfo(type: types.first)),
      ],
    );
  }
}
