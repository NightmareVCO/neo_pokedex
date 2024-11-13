import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PokeballBackground extends StatelessWidget {
  const PokeballBackground({super.key, required this.color});

  final String color;

  @override
  Widget build(BuildContext context) {
    switch (color) {
      case 'white':
        return SvgPicture.asset('assets/images/pokeball_white.svg');
      case 'white_s':
        return SvgPicture.asset('assets/images/pokeball_white_sm.svg');
      case 'black':
        return SvgPicture.asset('assets/images/pokeball_black_xs.svg');
      case 'black_s':
        return SvgPicture.asset('assets/images/pokeball_black_sm.svg');
    }

    return SvgPicture.asset('assets/images/pokeball_white.svg');
  }
}
