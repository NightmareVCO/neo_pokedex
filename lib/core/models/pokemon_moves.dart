class PokemonMove {
  final int level;
  final MoveLearnMethod moveLearnMethod;
  final Move move;

  PokemonMove(
      {required this.level, required this.moveLearnMethod, required this.move});

  factory PokemonMove.fromJson(Map<String, dynamic> json) {
    return PokemonMove(
      level: json['level'],
      moveLearnMethod:
          MoveLearnMethod.fromJson(json['pokemon_v2_movelearnmethod']),
      move: Move.fromJson(json['pokemon_v2_move']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'pokemon_v2_movelearnmethod': moveLearnMethod.toJson(),
      'pokemon_v2_move': move.toJson(),
    };
  }

  @override
  String toString() {
    return 'PokemonMove(level: $level, moveLearnMethod: $moveLearnMethod, move: $move)';
  }
}

class PokmenonGenericMove {
  final int id;
  final String name;

  PokmenonGenericMove({required this.id, required this.name});

  factory PokmenonGenericMove.fromJson(Map<String, dynamic> json) {
    return PokmenonGenericMove(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'PokmenonGenericMove(id: $id, name: $name)';
  }
}

class MoveLearnMethod {
  final String name;

  MoveLearnMethod({required this.name});

  factory MoveLearnMethod.fromJson(Map<String, dynamic> json) {
    return MoveLearnMethod(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  @override
  String toString() {
    return 'MoveLearnMethod(name: $name)';
  }
}

class Move {
  final int id;
  final String name;
  final int? power;
  final int? accuracy;
  final int pp;
  final MoveDamageClass moveDamageClass;
  final MoveType moveType;
  final MoveFlavor flavorText;

  Move({
    required this.id,
    required this.name,
    this.power,
    this.accuracy,
    required this.pp,
    required this.moveDamageClass,
    required this.moveType,
    required this.flavorText,
  });

  factory Move.fromJson(Map<String, dynamic> json) {
    return Move(
      id: json['id'],
      name: json['name'],
      power: json['power'],
      accuracy: json['accuracy'],
      pp: json['pp'],
      moveDamageClass:
          MoveDamageClass.fromJson(json['pokemon_v2_movedamageclass']),
      moveType: MoveType.fromJson(json['pokemon_v2_type']),
      flavorText: (json['pokemon_v2_moveflavortexts'] as List).isNotEmpty
          ? MoveFlavor.fromJson(json['pokemon_v2_moveflavortexts'][0])
          : MoveFlavor(flavorText: 'No description was found for this move'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'power': power,
      'accuracy': accuracy,
      'pp': pp,
      'pokemon_v2_movedamageclass': moveDamageClass.toJson(),
      'pokemon_v2_type': moveType.toJson(),
    };
  }

  @override
  String toString() {
    return 'Move(id: $id,name: $name, power: $power, accuracy: $accuracy, pp: $pp, moveDamageClass: $moveDamageClass, moveType: $moveType)';
  }
}

class MoveDamageClass {
  final String name;

  MoveDamageClass({required this.name});

  factory MoveDamageClass.fromJson(Map<String, dynamic> json) {
    return MoveDamageClass(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  @override
  String toString() {
    return 'MoveDamageClass(name: $name)';
  }
}

class MoveType {
  final String name;

  MoveType({required this.name});

  factory MoveType.fromJson(Map<String, dynamic> json) {
    return MoveType(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  @override
  String toString() {
    return 'MoveType(name: $name)';
  }
}

class MoveFlavor {
  final String flavorText;

  MoveFlavor({required this.flavorText});

  factory MoveFlavor.fromJson(Map<String, dynamic> json) {
    return MoveFlavor(
      flavorText: json['flavor_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flavor_text': flavorText,
    };
  }

  @override
  String toString() {
    return 'MoveFlavor(flavorText: $flavorText)';
  }
}
