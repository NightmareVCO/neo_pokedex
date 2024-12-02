import 'package:flutter/material.dart';
import 'package:neo_pokedex/ui/shared/components/heart_button.dart';
import 'package:neo_pokedex/ui/shared/components/home_button.dart';
import 'package:neo_pokedex/ui/shared/components/share_button.dart';
import 'package:neo_pokedex/ui/themes/pokemon_type_colors_bg.dart';
import 'package:screenshot/screenshot.dart';

class PokemonAppBar extends StatefulWidget implements PreferredSizeWidget {
  final ValueNotifier<double> scrollOffsetNotifier;
  final String imageUrl;
  final String type;
  final String name;
  final String pokemonId;
  final ScreenshotController screenshotController; // Added ScreenshotController

  const PokemonAppBar({
    super.key,
    required this.scrollOffsetNotifier,
    required this.imageUrl,
    required this.type,
    required this.name,
    required this.pokemonId,
    required this.screenshotController, // Added to constructor
  });

  @override
  _PokemonAppBarState createState() => _PokemonAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PokemonAppBarState extends State<PokemonAppBar> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: widget.scrollOffsetNotifier,
      builder: (context, scrollOffset, _) {
        return TweenAnimationBuilder<Color?>(
          tween: ColorTween(
            begin: Colors.white.withOpacity(0),
            end:
                scrollOffset > 200 ? Colors.white : Colors.white.withOpacity(0),
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
                  color: scrollOffset > 200 ? Colors.black : Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (scrollOffset > 200)
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(widget.imageUrl),
                      ),
                    const SizedBox(width: 10),
                    Text(
                      widget.name,
                      style: TextStyle(
                        color: scrollOffset > 200
                            ? pokemonTypeColorsBg[widget.type]
                            : Colors.transparent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                HomeIconButton(
                  color: scrollOffset > 200 ? Colors.black : Colors.white,
                ),
                HeartIconButton(
                  pokemonRef: widget.pokemonId,
                  color: scrollOffset > 200 ? Colors.black : Colors.white,
                ),
                ShareIconButton(
                  color: scrollOffset > 200 ? Colors.black : Colors.white,
                  screenshotController:
                      widget.screenshotController, // Passed controller
                ),
              ],
            );
          },
        );
      },
    );
  }
}
