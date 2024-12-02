import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors_bg.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_icons.dart';
import 'package:neo_pokedex/ui/widgets/page_pokemon_details_widgets/pokemon_tab_bar/pokemon_tab_bar_render.dart';
import 'package:neo_pokedex/utils/text_utils.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:neo_pokedex/core/services/graph_ql_service.dart';
import 'package:neo_pokedex/core/models/pokemon_moves.dart';

class PokemonListAppBar extends StatefulWidget implements PreferredSizeWidget {
  final List<Map<String, String>> orderBy;
  final int limit;
  final String sort;
  final List<String> types;
  final String search;
  final String generation;
  final String powerRange;
  final String move;
  final bool inFavorites;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onMoveChanged;
  final ValueChanged<bool> onFavoritesChanged;
  final ValueChanged<List<Map<String, String>>> onOrderByChanged;
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
    required this.search,
    required this.generation,
    required this.powerRange,
    required this.move,
    required this.inFavorites,
    required this.onSearchChanged,
    required this.onMoveChanged,
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
                powerRange.isNotEmpty ||
                move.isNotEmpty)
            ? 185.0
            : 115.0,
      );
}

class _PokemonListAppBarState extends State<PokemonListAppBar> {
  late final GraphQLService _graphQLService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final client = GraphQLProvider.of(context).value;
    _graphQLService = GraphQLService(client);
  }

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
                      fontSize: 16,
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
                    cursorColor: pokemonTypeColors['dragon'],
                    decoration: const InputDecoration(
                      hintText: 'Search Pokémon',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    onChanged: (value) {
                      widget.onSearchChanged(value);
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

      for (var order in widget.orderBy) {
        if (order['name'] == 'asc' || order['name'] == 'desc') {
          sortLabel = 'Name';
          sortIcon = Icons.sort_by_alpha;
        } else if (order['id'] == 'asc' || order['id'] == 'desc') {
          sortLabel = 'ID';
          sortIcon = Icons.format_list_numbered;
        } else if (order['type'] == 'asc' || order['type'] == 'desc') {
          sortLabel = 'Type';
          sortIcon = Icons.category;
        }
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
            widget.onOrderByChanged([]);
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
          label: Text('Gen. ${widget.generation.substring(11).toUpperCase()}',
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

    //add a chip for the selected move (is only 1 move at the same time)
    if (widget.move.isNotEmpty) {
      var customName = toTitleCaseWithSpaces(widget.move);
      chips.add(
        Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          side: const BorderSide(
            color: Colors.transparent,
          ),
          label: Text('Move: $customName',
              style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
          deleteIconColor: Colors.white,
          onDeleted: () {
            widget.onMoveChanged('');
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
          label: Text('Power: (${range[1]} - ${range[2]})',
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
    // String? selectedPowerRange =
    //     widget.powerRange.isNotEmpty ? widget.powerRange : null;
    String? selectedMove = widget.move.isNotEmpty ? widget.move : null;

    final bool? apply = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        // Move move-related state variables here
        List<PokmenonGenericMove> allMoves = [];
        bool isFetchingMoves = false;
        int moveOffset = 0;
        const int moveLimit = 20;
        bool hasMoreMoves = true;

        void fetchMoreMoves(void Function(void Function()) setState) async {
          setState(() {
            isFetchingMoves = true;
          });
          try {
            final moves = await _graphQLService.fetchAllMovesPokemons(
              limit: moveLimit,
              offset: moveOffset,
            );
            setState(() {
              allMoves.addAll(moves);
              moveOffset += moveLimit;
              if (moves.length < moveLimit) {
                hasMoreMoves = false;
              }
              isFetchingMoves = false;
            });
          } catch (e) {
            setState(() {
              isFetchingMoves = false;
            });
          }
        }

        return StatefulBuilder(
          builder: (context, setState) {
            return DefaultTabController(
              length: 3,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: TabBar(
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
                            tabs: ["Types", "Gens", "Moves"],
                            type: "dragon",
                          ).renderTabs()),
                    ),
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
                              final romanGeneration = toRoman(generation);
                              bool isSelected = selectedGeneration ==
                                  'generation-$romanGeneration';
                              return ListTile(
                                title: Text('Generation $generation'),
                                trailing: isSelected
                                    ? const Icon(Icons.check,
                                        color: Colors.green)
                                    : null,
                                onTap: () {
                                  setState(() {
                                    selectedGeneration = isSelected
                                        ? null
                                        : 'generation-$romanGeneration';
                                  });
                                },
                              );
                            }),
                          ),
                          // Moves Tab
                          Builder(
                            builder: (context) {
                              if (allMoves.isEmpty && !isFetchingMoves) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  fetchMoreMoves(setState);
                                });
                              }
                              return NotificationListener<ScrollNotification>(
                                onNotification:
                                    (ScrollNotification scrollInfo) {
                                  if (!isFetchingMoves &&
                                      hasMoreMoves &&
                                      scrollInfo.metrics.pixels ==
                                          scrollInfo.metrics.maxScrollExtent) {
                                    fetchMoreMoves(setState);
                                  }
                                  return false;
                                },
                                child: ListView.builder(
                                  itemCount: allMoves.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == allMoves.length) {
                                      if (hasMoreMoves) {
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: CircularProgressIndicator(
                                                color: pokemonTypeColors[
                                                    'dragon']),
                                          ),
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    }
                                    final move = allMoves[index];
                                    bool isSelected = selectedMove == move.name;
                                    return ListTile(
                                      title: Text(
                                          toTitleCaseWithSpaces(move.name)),
                                      trailing: isSelected
                                          ? const Icon(Icons.check,
                                              color: Colors.green)
                                          : null,
                                      onTap: () {
                                        setState(() {
                                          selectedMove =
                                              isSelected ? null : move.name;
                                        });
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 30, left: 20, right: 20, top: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: pokemonTypeColors['dragon'],
                          ),
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text(
                            'Apply',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
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

      if (selectedMove != null && selectedMove != widget.move) {
        widget.onMoveChanged(selectedMove!);
      } else if (selectedMove == null && widget.move.isNotEmpty) {
        widget.onMoveChanged('');
      }

      // if (selectedPowerRange != null &&
      //     selectedPowerRange != widget.powerRange) {
      //   widget.onPowerRangeChanged(selectedPowerRange!);
      // }
    }
  }

  void _showSortOptions() async {
    bool isAscending = true; // Add state for sort order
    String? currentSortOption; // Add state for current sort option

    // Determine the current sort option and order
    if (widget.orderBy.isNotEmpty) {
      var firstOrder = widget.orderBy.first;
      currentSortOption = firstOrder.keys.first;
      isAscending = firstOrder[currentSortOption] == 'asc';
    }

    final String? selectedOption = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const ListTile(
                      title: Text(
                        'Sort by',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Add check marks to sort options
                    ListTile(
                      leading: const Icon(Icons.sort_by_alpha),
                      title: const Text('Name'),
                      trailing: currentSortOption == 'name'
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () {
                        setState(() {
                          currentSortOption = 'name';
                        });
                        Navigator.pop(context, 'name');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.format_list_numbered),
                      title: const Text('ID'),
                      trailing: currentSortOption == 'id'
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () {
                        setState(() {
                          currentSortOption = 'id';
                        });
                        Navigator.pop(context, 'id');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.category),
                      title: const Text('Type'),
                      trailing: currentSortOption == 'type'
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () {
                        setState(() {
                          currentSortOption = 'type';
                        });
                        Navigator.pop(context, 'type');
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: currentSortOption == null
                              ? null
                              : () {
                                  setState(() {
                                    isAscending = true;
                                    widget.onOrderByChanged([
                                      {currentSortOption!: 'asc'}
                                    ]);
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isAscending
                                ? pokemonTypeColors['dragon']
                                : Colors.white,
                            // Añadir color cuando está deshabilitado
                            disabledBackgroundColor: Colors.grey[300],
                          ),
                          child: Text(
                            'Ascending',
                            style: TextStyle(
                              color: currentSortOption == null
                                  ? Colors.grey[600]
                                  : (isAscending
                                      ? Colors.white
                                      : pokemonTypeColors['dragon']),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: currentSortOption == null
                              ? null
                              : () {
                                  setState(() {
                                    isAscending = false;
                                    widget.onOrderByChanged([
                                      {currentSortOption!: 'desc'}
                                    ]);
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: !isAscending
                                ? pokemonTypeColors['dragon']
                                : Colors.white,
                            // Añadir color cuando está deshabilitado
                            disabledBackgroundColor: Colors.grey[300],
                          ),
                          child: Text(
                            'Descending',
                            style: TextStyle(
                              color: currentSortOption == null
                                  ? Colors.grey[600]
                                  : (!isAscending
                                      ? Colors.white
                                      : pokemonTypeColors['dragon']),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (selectedOption != null) {
      widget.onOrderByChanged([
        {selectedOption: isAscending ? 'asc' : 'desc'}
      ]);
    }
  }
}
