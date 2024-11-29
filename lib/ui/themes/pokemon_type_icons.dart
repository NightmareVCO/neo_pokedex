import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Map<String, String> pokemonTypeIcons = {
  "normal": "assets/icons/normal.svg",
  "fighting": "assets/icons/fighting.svg",
  "flying": "assets/icons/flying.svg",
  "poison": "assets/icons/poison.svg",
  "ground": "assets/icons/ground.svg",
  "rock": "assets/icons/rock.svg",
  "bug": "assets/icons/bug.svg",
  "ghost": "assets/icons/ghost.svg",
  "steel": "assets/icons/steel.svg",
  "fire": "assets/icons/fire.svg",
  "water": "assets/icons/water.svg",
  "grass": "assets/icons/grass.svg",
  "electric": "assets/icons/electric.svg",
  "psychic": "assets/icons/psychic.svg",
  "ice": "assets/icons/ice.svg",
  "dragon": "assets/icons/dragon.svg",
  "dark": "assets/icons/dark.svg",
  "fairy": "assets/icons/fairy.svg",
};

Map<String, IconData> pokemonTypeOldIcons = {
  "normal": Icons.circle,
  "fighting": Icons.back_hand,
  "flying": Icons.cloud,
  "poison": Icons.bug_report,
  "ground": Icons.public,
  "rock": Icons.terrain,
  "bug": Icons.bug_report,
  "ghost": Icons.foggy,
  "steel": Icons.build,
  "fire": Icons.whatshot,
  "water": Icons.water_drop,
  "grass": Icons.eco,
  "electric": Icons.flash_on,
  "psychic": Icons.psychology,
  "ice": Icons.ac_unit,
  "dragon": Icons.whatshot,
  "dark": Icons.brightness_3,
  "fairy": Icons.favorite,
  "stellar": Icons.star,
};

Widget getPokemonTypeIcon(String type, {double size = 20, ColorFilter? color}) {
  String? assetPath = pokemonTypeIcons[type.toLowerCase()];
  if (assetPath == null) {
    return Container();
  }

  return SvgPicture.asset(
    assetPath,
    colorFilter: color,
    width: size,
    height: size,
  );

  // return Icon(
  //   pokemonTypeOldIcons[type.toLowerCase()],
  //   size: size,
  //   color: Colors.white,
  // );
}
