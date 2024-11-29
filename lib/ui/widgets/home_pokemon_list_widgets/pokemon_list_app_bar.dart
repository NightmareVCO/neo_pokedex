import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors_bg.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_icons.dart';
import 'package:neo_pokedex/utils/text_utils.dart';

class PokemonListAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String orderBy;
  final int limit;
  final String sort;
  final String type;
  final ValueChanged<String> onOrderByChanged;
  final ValueChanged<int> onLimitChanged;
  final ValueChanged<String> onSortChanged;
  final ValueChanged<String> onTypeChanged;

  const PokemonListAppBar({
    super.key,
    required this.orderBy,
    required this.limit,
    required this.sort,
    required this.type,
    required this.onOrderByChanged,
    required this.onLimitChanged,
    required this.onSortChanged,
    required this.onTypeChanged,
  });

  @override
  State<PokemonListAppBar> createState() => _PokemonListAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(
        (!sort.isNotEmpty || !type.isNotEmpty) ? 115.0 : 185.0,
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
          const Text(
            'Neo Pokédex',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Colors.red,
            ),
          ),
          const Text(
            'Gotta catch \'em all!',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
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
          Wrap(
            spacing: 8.0,
            children: _buildFilterChips(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFilterChips() {
    List<Widget> chips = [];

    if (widget.type.isNotEmpty) {
      chips.add(
        Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          side: const BorderSide(
            color: Colors.transparent,
          ),
          label: Text(
            toTitleCase(widget.type),
            style: const TextStyle(color: Colors.white),
          ),
          avatar: getPokemonTypeIcon(
            widget.type,
            size: 20,
            color: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          backgroundColor: pokemonTypeColorsBg[widget.type],
          deleteIconColor: Colors.white,
          onDeleted: () {
            widget.onTypeChanged('');
          },
        ),
      );
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
    }

    return chips;
  }

  void _showFilterOptions() async {
    final String? selectedType = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: pokemonTypeIcons.keys.map((type) {
            return ListTile(
              leading: getPokemonTypeIcon(type,
                  size: 24,
                  color: ColorFilter.mode(
                      pokemonTypeColorsBg[type.toLowerCase()]!,
                      BlendMode.srcIn)),
              title: Text(
                toTitleCase(type),
                style: TextStyle(
                    color: pokemonTypeColorsBg[type.toLowerCase()],
                    fontSize: 18),
              ),
              onTap: () {
                Navigator.pop(context, type);
              },
            );
          }).toList(),
        );
      },
    );

    if (selectedType != null) {
      widget.onTypeChanged(selectedType);
      // Filtrado
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
