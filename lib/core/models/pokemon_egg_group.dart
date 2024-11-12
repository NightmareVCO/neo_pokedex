class EggGroup {
  final String eggGroupName;
  final String speciesName;

  EggGroup({
    required this.eggGroupName,
    required this.speciesName,
  });

  factory EggGroup.fromJson(Map<String, dynamic> json) {
    return EggGroup(
      eggGroupName: json['pokemon_v2_egggroup']['name'],
      speciesName: json['pokemon_v2_pokemonspecy']['name'],
    );
  }
}
