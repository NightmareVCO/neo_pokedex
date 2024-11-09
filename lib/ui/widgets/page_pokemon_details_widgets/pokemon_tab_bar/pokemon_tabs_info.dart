import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tab_bar.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tabs/pokemon_about_tab.dart';
import 'package:neo_pokedex/utils/text_utils.dart';

class PokemonTabsInfo extends StatelessWidget {
  final String type;

  const PokemonTabsInfo({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      width: double.infinity,
      child: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            PokemonTabBar(type: type),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: PokemonAboutTab(
                      about: removeNewLines(
                          "Spits fire that\nis hot enough to\nmelt boulders.\fKnown to cause\nforest fires\nunintentionally."),
                      type: type,
                      captureRate: "45%",
                      height: "1.7",
                      weight: "90.5",
                    ),
                  ),
                  const SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Stats information here..."),
                          // Añade más contenido para mostrar el scroll en la pestaña Stats
                          Text("Información adicional..."),
                          // Puedes añadir más información aquí
                        ],
                      ),
                    ),
                  ),
                  const SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Stats information here..."),
                          // Añade más contenido para mostrar el scroll en la pestaña Stats
                          Text("Información adicional..."),
                          // Puedes añadir más información aquí
                        ],
                      ),
                    ),
                  ),
                  const SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Stats information here..."),
                          // Añade más contenido para mostrar el scroll en la pestaña Stats
                          Text("Información adicional..."),
                          // Puedes añadir más información aquí
                        ],
                      ),
                    ),
                  ),
                  const SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Stats information here..."),
                          // Añade más contenido para mostrar el scroll en la pestaña Stats
                          Text("Información adicional..."),
                          // Puedes añadir más información aquí
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
