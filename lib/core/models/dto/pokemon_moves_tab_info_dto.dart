import 'package:neo_pokedex/core/models/pokemon_moves.dart';

class PokemonMovesTabInfoDto {
  final String type;
  final List<PokemonMoveTextDto> moves;

  PokemonMovesTabInfoDto({required this.moves, required this.type});

  static PokemonMovesTabInfoDto fromJson(
      Map<String, dynamic> json, String type) {
    List<PokemonMoveTextDto> moves = [];
    for (var move in json['moves']) {
      moves.add(PokemonMoveTextDto.fromJson(move));
    }
    return PokemonMovesTabInfoDto(type: type, moves: moves);
  }
}

class PokemonMoveTextDto {
  final String level;
  final String method;
  final String move;
  final String movePower;
  final String moveAccuracy;
  final String moveType;
  final String moveDamageClass;
  final String movePP;
  final String moveFlavorText;

  PokemonMoveTextDto(
      {required this.level,
      required this.method,
      required this.move,
      required this.movePower,
      required this.moveAccuracy,
      required this.moveType,
      required this.moveDamageClass,
      required this.movePP,
      required this.moveFlavorText});

  static PokemonMoveTextDto fromJson(Map<String, dynamic> json) {
    return PokemonMoveTextDto(
      level: json['level'],
      method: json['method'],
      move: json['move'],
      movePower: json['movePower'],
      moveAccuracy: json['moveAccuracy'],
      moveType: json['moveType'],
      moveDamageClass: json['moveDamageClass'],
      movePP: json['movePP'],
      moveFlavorText: json['moveFlavorText'],
    );
  }

  factory PokemonMoveTextDto.fromMove(PokemonMove move) {
    return PokemonMoveTextDto(
      level: move.level.toString(),
      method: move.moveLearnMethod.name,
      move: move.move.name,
      movePower: move.move.power?.toString() ?? 'n/a',
      moveAccuracy: move.move.accuracy?.toString() ?? 'n/a',
      moveType: move.move.moveType.name,
      moveDamageClass: move.move.moveDamageClass.name,
      movePP: move.move.pp.toString(),
      moveFlavorText: move.move.flavorText.flavorText,
    );
  }
}
