import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors_bg.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_icons.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tab_bar_render.dart';
import 'package:neo_pokedex/utils/text_utils.dart';

class PokemonListAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String orderBy;
  final int limit;
  final String sort;
  final List<String> types;
  final String generation;
  final String powerRange;
  final bool inFavorites;
  final ValueChanged<bool> onFavoritesChanged;
  final ValueChanged<String> onOrderByChanged;
  final ValueChanged<String> onGenerationChanged;
  final ValueChanged<String> onPowerRangeChanged;
  final ValueChanged<int> onLimitChanged;
  final ValueChanged<String> onSortChanged;
  final ValueChanged<String> onTypeChanged;

  const PokemonListAppBar({
    super.key,
    required this.orderBy,
    required this.limit,
    required this.sort,
    required this.types,
    required this.generation,
    required this.powerRange,
    required this.inFavorites,
    required this.onFavoritesChanged,
    required this.onOrderByChanged,
    required this.onGenerationChanged,
    required this.onPowerRangeChanged,
    required this.onLimitChanged,
    required this.onSortChanged,
    required this.onTypeChanged,
  });

  @override
  State<PokemonListAppBar> createState() => _PokemonListAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(
        (types.isNotEmpty ||
                orderBy.isNotEmpty ||
                generation.isNotEmpty ||
                powerRange.isNotEmpty)
            ? 185.0
            : 115.0,
      );
}

class _PokemonListAppBarState extends State<PokemonListAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 200,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  Text(
                    'Neo Pokédex',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    'Gotta catch \'em all!',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              //IconButton to change favorite status
              IconButton(
                icon: Icon(
                  widget.inFavorites ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                  size: 30,
                ),
                onPressed: () {
                  widget.onFavoritesChanged(!widget.inFavorites);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                onPressed: _showFilterOptions,
                icon: const Icon(Icons.filter_list),
                color: Colors.black,
              ),
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search Pokémon',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    onChanged: (value) {
                      // search logic here
                    },
                  ),
                ),
              ),
              IconButton(
                onPressed: _showSortOptions,
                icon: const Icon(Icons.sort),
                color: Colors.black,
              ),
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _buildFilterChips(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFilterChips() {
    List<Widget> chips = [];

    // Handle multiple types
    for (String type in widget.types) {
      chips.add(
        Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          side: const BorderSide(
            color: Colors.transparent,
          ),
          label: Text(
            toTitleCase(type),
            style: const TextStyle(color: Colors.white),
          ),
          avatar: getPokemonTypeIcon(
            type,
            size: 20,
            color: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          backgroundColor: pokemonTypeColorsBg[type],
          deleteIconColor: Colors.white,
          onDeleted: () {
            widget.onTypeChanged(type);
          },
        ),
      );
      chips.add(const SizedBox(width: 8));
    }

    if (widget.orderBy.isNotEmpty) {
      String sortLabel = '';
      IconData sortIcon = Icons.sort;

      switch (widget.orderBy) {
        case 'name':
          sortLabel = 'Name';
          sortIcon = Icons.sort_by_alpha;
          break;
        case 'id':
          sortLabel = 'ID';
          sortIcon = Icons.format_list_numbered;
          break;
      }

      chips.add(
        Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          side: const BorderSide(
            color: Colors.transparent,
          ),
          label: Text(sortLabel, style: const TextStyle(color: Colors.white)),
          avatar: Icon(
            sortIcon,
            color: Colors.white,
          ),
          backgroundColor: Colors.amber,
          deleteIconColor: Colors.white,
          onDeleted: () {
            widget.onOrderByChanged('');
          },
        ),
      );
      chips.add(const SizedBox(width: 8));
    }

    // add a chip for generation
    if (widget.generation.isNotEmpty) {
      chips.add(
        Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          side: const BorderSide(
            color: Colors.transparent,
          ),
          label: Text('Gen ${widget.generation.substring(4)}',
              style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
          deleteIconColor: Colors.white,
          onDeleted: () {
            widget.onGenerationChanged('');
          },
        ),
      );
      chips.add(const SizedBox(width: 8));
    }

    // add a chip for power range
    if (widget.powerRange.isNotEmpty) {
      final List<String> range = widget.powerRange.split('_');
      chips.add(
        Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          side: const BorderSide(
            color: Colors.transparent,
          ),
          label: Text('Power (${range[1]} - ${range[2]})',
              style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
          deleteIconColor: Colors.white,
          onDeleted: () {
            widget.onPowerRangeChanged('');
          },
        ),
      );
      chips.add(const SizedBox(width: 8));
    }

    return chips;
  }

  void _showFilterOptions() async {
    List<String> selectedTypes = List.from(widget.types);
    String? selectedGeneration =
        widget.generation.isNotEmpty ? widget.generation : null;
    String? selectedPowerRange =
        widget.powerRange.isNotEmpty ? widget.powerRange : null;

    final bool? apply = await showModalBottomSheet<bool>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return DefaultTabController(
              length: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TabBar(
                        labelColor: Colors.white,
                        dividerColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        unselectedLabelColor: pokemonTypeColors['dragon'],
                        unselectedLabelStyle: const TextStyle(fontSize: 16),
                        indicatorColor: pokemonTypeColors['dragon'],
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 8),
                        indicator: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                          color: pokemonTypeColors['dragon'],
                        ),
                        tabs: PokemonTabBarRender(
                          tabs: ["Types", "Gens", "Power"],
                          type: "dragon",
                        ).renderTabs()),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Types Tab
                          ListView(
                            children: pokemonTypeIcons.keys.map((type) {
                              bool isSelected = selectedTypes.contains(type);
                              return ListTile(
                                leading: getPokemonTypeIcon(type,
                                    size: 24,
                                    color: ColorFilter.mode(
                                        pokemonTypeColorsBg[
                                            type.toLowerCase()]!,
                                        BlendMode.srcIn)),
                                title: Text(
                                  toTitleCase(type),
                                  style: TextStyle(
                                      color: pokemonTypeColorsBg[
                                          type.toLowerCase()],
                                      fontSize: 18),
                                ),
                                trailing: isSelected
                                    ? const Icon(Icons.check,
                                        color: Colors.green)
                                    : null,
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedTypes.remove(type);
                                    } else {
                                      selectedTypes.add(type);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                          ),
                          // Generations Tab
                          ListView(
                            children: List.generate(9, (index) {
                              final generation = index + 1;
                              bool isSelected =
                                  selectedGeneration == 'gen_$generation';
                              return ListTile(
                                title: Text('Generation $generation'),
                                trailing: isSelected
                                    ? const Icon(Icons.check,
                                        color: Colors.green)
                                    : null,
                                onTap: () {
                                  setState(() {
                                    selectedGeneration =
                                        isSelected ? null : 'gen_$generation';
                                  });
                                },
                              );
                            }),
                          ),
                          // Power Ranges Tab
                          ListView(
                            children: List.generate(8, (index) {
                              final start = 50 + index * 20;
                              final end = start + 20;
                              String range = 'power_${start}_$end';
                              bool isSelected = selectedPowerRange == range;
                              return ListTile(
                                title: Text('Poder ($start - $end)'),
                                trailing: isSelected
                                    ? const Icon(Icons.check,
                                        color: Colors.green)
                                    : null,
                                onTap: () {
                                  setState(() {
                                    selectedPowerRange =
                                        isSelected ? null : range;
                                  });
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text('Apply',
                            style:
                                TextStyle(color: pokemonTypeColors['dragon'])),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (apply == true) {
      Set<String> selectedSet = selectedTypes.toSet();
      Set<String> currentSet = widget.types.toSet();

      Set<String> toAdd = selectedSet.difference(currentSet);
      Set<String> toRemove = currentSet.difference(selectedSet);

      for (String type in toAdd) {
        if (type.isNotEmpty) {
          widget.onTypeChanged(type);
        }
      }

      for (String type in toRemove) {
        widget.onTypeChanged(type);
      }

      if (selectedGeneration != null &&
          selectedGeneration != widget.generation) {
        widget.onGenerationChanged(selectedGeneration!);
      }

      if (selectedPowerRange != null &&
          selectedPowerRange != widget.powerRange) {
        widget.onPowerRangeChanged(selectedPowerRange!);
      }
    }
  }

  void _showSortOptions() async {
    final String? selectedOption = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.sort_by_alpha),
              title: const Text('name'),
              onTap: () {
                Navigator.pop(context, 'name');
              },
            ),
            ListTile(
              leading: const Icon(Icons.format_list_numbered),
              title: const Text('id'),
              onTap: () {
                Navigator.pop(context, 'id');
              },
            ),
          ],
        );
      },
    );

    if (selectedOption != null) {
      widget.onOrderByChanged(selectedOption);
    }
  }
}
