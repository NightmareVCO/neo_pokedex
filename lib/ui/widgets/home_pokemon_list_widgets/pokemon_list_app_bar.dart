import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors_bg.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_icons.dart';
import 'package:neo_pokedex/utils/text_utils.dart';

class PokemonListAppBar extends StatefulWidget implements PreferredSizeWidget {
  const PokemonListAppBar({super.key});

  @override
  State<PokemonListAppBar> createState() => _PokemonListAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(185);
}

class _PokemonListAppBarState extends State<PokemonListAppBar> {
  String _selectedType = '';
  String _selectedSortOption = '';

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
                      // Handle search logic here
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
          // Añadimos las Chips aquí
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

    if (_selectedType.isNotEmpty) {
      chips.add(
        Chip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          side: const BorderSide(
            color: Colors.transparent,
          ),
          label: Text(
            toTitleCase(_selectedType),
            style: const TextStyle(color: Colors.white),
          ),
          avatar: Icon(
            pokemonTypeIcons[_selectedType],
            color: Colors.white,
          ),
          backgroundColor: pokemonTypeColorsBg[_selectedType],
          deleteIconColor: Colors.white,
          onDeleted: () {
            setState(() {
              _selectedType = '';
            });
            // Actualiza la lista de Pokémon filtrada
          },
        ),
      );
    }

    if (_selectedSortOption.isNotEmpty) {
      String sortLabel = '';
      IconData sortIcon = Icons.sort;

      switch (_selectedSortOption) {
        case 'name':
          sortLabel = 'Name';
          sortIcon = Icons.sort_by_alpha;
          break;
        case 'order':
          sortLabel = 'Order';
          sortIcon = Icons.format_list_numbered;
          break;
        case 'type':
          sortLabel = 'Type';
          sortIcon = Icons.category;
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
            setState(() {
              _selectedSortOption = '';
            });
            // Actualiza la lista de Pokémon ordenada
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
              leading: Icon(
                pokemonTypeIcons[type],
                color: pokemonTypeColorsBg[type.toLowerCase()],
              ),
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
      setState(() {
        _selectedType = selectedType;
      });
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
              title: const Text('Nombre'),
              onTap: () {
                Navigator.pop(context, 'name');
              },
            ),
            ListTile(
              leading: const Icon(Icons.format_list_numbered),
              title: const Text('Orden'),
              onTap: () {
                Navigator.pop(context, 'order');
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Tipo'),
              onTap: () {
                Navigator.pop(context, 'type');
              },
            ),
          ],
        );
      },
    );

    if (selectedOption != null) {
      setState(() {
        _selectedSortOption = selectedOption;
      });
      // Aquí puedes aplicar la lógica de ordenamiento en tu lista de Pokémon
    }
  }
}
