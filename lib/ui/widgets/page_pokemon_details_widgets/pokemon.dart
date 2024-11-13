import 'package:flutter/material.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_about_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_evolution_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_moves_tab_info_dto.dart';
import 'package:neo_pokedex/core/models/dto/pokemon_stats_tab_info_dto.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_image.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_name.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_number.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tabs_info.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_types.dart';
import 'package:neo_pokedex/utils/text_utils.dart';

class Pokemon extends StatelessWidget {
  Pokemon({
    super.key,
    required this.name,
    required this.number,
    required this.habitat,
    required this.types,
    required this.imageUrl,
    required this.cryUrl,
  });

  //TODO: Tenemos esto pero realmente solo deberia recibir un objeto Pokemon y no todos sus atributos.
  final String name;
  final String number;
  final String habitat;
  final List<String> types;
  final String imageUrl;
  final String cryUrl;

  //ESO NO
  // const PokemonInformationTextDto pokemonInformationTextDto = PokemonInformationTextDto(
  //   type: "Fire",
  //   baseExperience: "267",
  //   growthRate: "medium-slow",
  //   shape: "upright",
  //   isLegendary: "Is not legendary",
  //   isMythical: "Is not mythical",
  // );

  //ESTO SI
  // PokemonInformationTextDto pokemonInformationTextDto = PokemonInformationTextDto.fromJson(json);

  final PokemonFlavourTextDto pokemonFlavourTextDto = PokemonFlavourTextDto(
    type: "fire",
    about: removeNewLines(
        "Spits fire that\nis hot enough to\nmelt boulders.\fKnown to cause\nforest fires\nunintentionally."),
    captureRate: "45%",
    height: "1.7",
    weight: "90.5",
  );

  final PokemonInformationTextDto pokemonInformationTextDto =
      PokemonInformationTextDto(
    type: "fire",
    baseExperience: "267",
    growthRate: "medium-slow",
    shape: "upright",
    isLegendary: "Is not legendary",
    isMythical: "Is not mythical",
  );

  final PokemonBreedingTextDto pokemonBreedingTextDto = PokemonBreedingTextDto(
    type: "fire",
    eggCycle: 1,
    eggGroups: ["Dragon", "Monster"],
  );

  final PokemonStatsTextDto pokemonStatsTextDto = PokemonStatsTextDto(
    type: "fire",
    attack: 84,
    defense: 78,
    specialAttack: 109,
    specialDefense: 85,
    speed: 100,
  );

  final PokemonTypeEffectivenessTextDto pokemonTypeEffectivenessTextDto =
      PokemonTypeEffectivenessTextDto(type: 'fire');

  final PokemonMovesTabInfoDto pokemonMovesTabInfoDto = PokemonMovesTabInfoDto(
    type: "fire",
    moves: [
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
      PokemonMoveTextDto(
        level: "1",
        method: "tutor",
        move: "ember",
        movePower: "40",
        moveAccuracy: "100",
        moveType: "fire",
        moveDamageClass: "special",
        movePP: "25",
      ),
    ],
  );

  final PokemonEvolutionTextDto pokemonEvolutionTextDto1 =
      PokemonEvolutionTextDto(
    type: "fire",
    id: "4",
    text: "Charmander evolves into Charmeleon at level 16.",
    level: "0",
    name: "Charmander",
    imageUrl:
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png",
    predecessor: "Charmander",
    types: ["fire"],
  );

  final PokemonEvolutionTextDto pokemonEvolutionTextDto2 =
      PokemonEvolutionTextDto(
    type: "fire",
    id: "5",
    text: "Charmeleon evolves into Charizard at level 36.",
    level: "16",
    name: "Charmeleon",
    imageUrl:
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/5.png",
    predecessor: "Charmeleon",
    types: ["fire"],
  );

  final PokemonEvolutionTextDto pokemonEvolutionTextDto3 =
      PokemonEvolutionTextDto(
    type: "fire",
    id: "6",
    text: "Charizard is the final form of Charmander.",
    level: "36",
    name: "Charizard",
    imageUrl:
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/6.png",
    predecessor: "Charmeleon",
    types: ["fire", "flying"],
  );

  final PokemonEvolutionTextDto pokemonEvolutionTextDtoMega1 =
      PokemonEvolutionTextDto(
    type: "fire",
    id: "10034",
    text: "Charizard Mega x is the final form of Charmander X.",
    level: "36",
    name: "Charizard Mega x",
    imageUrl:
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/10034.png",
    predecessor: "Charmeleon",
    types: ["fire", "dragon"],
  );

  final PokemonEvolutionTextDto pokemonEvolutionTextDtoMega2 =
      PokemonEvolutionTextDto(
    type: "fire",
    id: "10035",
    text: "Charizard Mega y is the final form of Charmander Y.",
    level: "36",
    name: "Charizard Mega y",
    imageUrl:
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/10035.png",
    predecessor: "Charmeleon",
    types: ["fire", "flying"],
  );

  //giga
  final PokemonEvolutionTextDto pokemonEvolutionTextDtoGiga1 =
      PokemonEvolutionTextDto(
    type: "fire",
    id: "10036",
    text: "Charizard Giga x is the final form of Charmander X.",
    level: "36",
    name: "Charizard Gmax",
    imageUrl:
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/10196.png",
    predecessor: "Charmeleon",
    types: ["fire", "flying"],
  );

  @override
  Widget build(BuildContext context) {
    final PokemonAboutTabInfoDto pokemonAboutTabInfoDto =
        PokemonAboutTabInfoDto(
      type: "fire",
      pokemonFlavourTextDto: pokemonFlavourTextDto,
      pokemonInformationTextDto: pokemonInformationTextDto,
      pokemonBreedingTextDto: pokemonBreedingTextDto,
    );

    final PokemonStatsTabInfoDto pokemonStatsTabInfoDto =
        PokemonStatsTabInfoDto(
            pokemonStatsTextDto: pokemonStatsTextDto,
            pokemonTypeEffectivenessTextDto: pokemonTypeEffectivenessTextDto);

    final PokemonEvolutionTabInfoDto pokemonEvolutionTabInfoDto =
        PokemonEvolutionTabInfoDto(
      type: "fire",
      pokemonEvolutionTextDto: [
        pokemonEvolutionTextDto1,
        pokemonEvolutionTextDto2,
        pokemonEvolutionTextDto3
      ],
      pokemonMegaEvolutionTextDto: [
        pokemonEvolutionTextDtoMega1,
        pokemonEvolutionTextDtoMega2,
        pokemonEvolutionTextDtoGiga1,
      ],
    );

    return Column(
      children: [
        PokemonNumber(number: number, habitat: habitat),
        PokemonName(name: name),
        PokemonTypes(types: types),
        PokemonImage(
          cryUrl: cryUrl,
          imageUrl: imageUrl,
          id: number,
        ),
        const SizedBox(height: 10),
        SizedBox(
            height: 1000,
            child: PokemonTabsInfo(
                pokemonAboutTabInfoDto: pokemonAboutTabInfoDto,
                pokemonStatsTabInfoDto: pokemonStatsTabInfoDto,
                pokemonMovesTabInfoDto: pokemonMovesTabInfoDto,
                pokemonEvolutionTabInfoDto: pokemonEvolutionTabInfoDto)),
      ],
    );
  }
}
