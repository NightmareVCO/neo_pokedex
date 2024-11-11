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

  PokemonMoveTextDto(
      {required this.level,
      required this.method,
      required this.move,
      required this.movePower,
      required this.moveAccuracy,
      required this.moveType,
      required this.moveDamageClass,
      required this.movePP});

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
    );
  }
}
