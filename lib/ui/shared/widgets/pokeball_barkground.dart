import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PokeballBackground extends StatelessWidget {
  const PokeballBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 100,
        right: -100,
        child: SvgPicture.asset('assets/images/pokeball_white_3.svg'));
  }
}
