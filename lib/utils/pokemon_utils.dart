import 'package:neo_pokedex/core/models/dto/pokemon_evolution_tab_info_dto.dart';

final Map<String, String> specialEvolutions = {
  '135': 'Item: Thunder Stone',
  '136': 'Item: Fire Stone',
  '196': 'Item: Sun Stone',
  '197': 'Item: Moon Stone',
  '470': 'Item: Leaf Stone',
  '471': 'Item: Ice Stone',
  '700': 'Item: Shiny Stone',
};

String getEvolutionText(PokemonEvolutionTextDto evolution) {
  if (specialEvolutions.containsKey(evolution.id)) {
    return specialEvolutions[evolution.id]!;
  }

  if (evolution.level != 'Unknown') {
    return 'Lv. ${evolution.level}';
  } else if (evolution.item != 'Unknown') {
    return 'Item: ${evolution.item}';
  } else if (evolution.happiness != 'Unknown') {
    return 'Happiness: ${evolution.happiness}';
  } else if (evolution.trigger != 'Unknown') {
    return evolution.trigger;
  }
  return '';
}
