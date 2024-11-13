import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/shared/components/heart_button.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors_bg.dart';

class PokemonAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double scrollOffset;
  final String imageUrl;
  final String type;

  const PokemonAppBar(
      {super.key,
      required this.scrollOffset,
      required this.imageUrl,
      required this.type});

  @override
  _PokemonAppBarState createState() => _PokemonAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PokemonAppBarState extends State<PokemonAppBar> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(
        begin: Colors.white.withOpacity(0), // Color al inicio
        end: widget.scrollOffset > 200
            ? Colors.white
            : Colors.white.withOpacity(0), // Color al alcanzar el offset
      ),
      duration: const Duration(milliseconds: 300),
      builder: (context, color, child) {
        return AppBar(
          elevation: 0,
          backgroundColor: color,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: widget.scrollOffset > 200 ? Colors.black : Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.scrollOffset > 200)
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(widget.imageUrl),
                  ),
                const SizedBox(width: 10),
                Text(
                  "Charizard",
                  style: TextStyle(
                    color: widget.scrollOffset > 200
                        ? pokemonTypeColorsBg[widget.type]
                        : Colors.transparent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            HeartIconButton(
              color: widget.scrollOffset > 200 ? Colors.black : Colors.white,
            ),
          ],
        );
      },
    );
  }
}
