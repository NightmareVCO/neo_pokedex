import 'package:flutter/material.dart';

var opacity = 0.7;

Map<String, Color> pokemonTypeColorsBg = {
  "normal": Colors.grey.withOpacity(opacity),
  "fighting": Colors.red.withOpacity(opacity),
  "flying": Colors.blue[400]!.withOpacity(opacity),
  "poison": Colors.purple.withOpacity(opacity),
  "ground": Colors.brown.withOpacity(opacity),
  "rock": Colors.grey[800]!.withOpacity(opacity),
  "bug": Colors.green.withOpacity(opacity),
  "ghost": Colors.indigo.withOpacity(opacity),
  "steel": Colors.blueGrey.withOpacity(opacity),
  "fire": Colors.orange.withOpacity(opacity),
  "water": Colors.blue.withOpacity(opacity),
  "grass": Colors.green[700]!.withOpacity(opacity),
  "electric": const Color.fromARGB(255, 255, 186, 11).withOpacity(opacity),
  "psychic": Colors.pink.withOpacity(opacity),
  "ice": Colors.cyan.withOpacity(opacity),
  "dragon": Colors.redAccent.withOpacity(opacity),
  "dark": Colors.black.withOpacity(opacity),
  "fairy": Colors.pinkAccent.withOpacity(opacity),
};
