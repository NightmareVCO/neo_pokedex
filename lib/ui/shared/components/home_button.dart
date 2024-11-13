import 'package:flutter/material.dart';

class HomeIconButton extends StatelessWidget {
  final Color color;
  const HomeIconButton({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.home_outlined,
        color: color,
        size: 30,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
