class Generation {
  final int id;
  final String name;

  Generation({
    required this.id,
    required this.name,
  });

  factory Generation.fromJson(Map<String, dynamic> json) {
    return Generation(
      id: json['id'],
      name: json['pokemon_v2_generationnames'][0]['name'],
    );
  }
}