import 'package:flutter/material.dart';

class PokemonListAppBar extends StatefulWidget implements PreferredSizeWidget {
  const PokemonListAppBar({super.key});

  @override
  State<PokemonListAppBar> createState() => _PokemonListAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(120);
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
          const Row(
            children: [
              Column(
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
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
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
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
                color: Colors.black,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.sort),
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
