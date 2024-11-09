import 'package:flutter/material.dart';

class HeartIconButton extends StatefulWidget {
  final Color color;
  const HeartIconButton({super.key, required this.color});

  @override
  // ignore: library_private_types_in_public_api
  _HeartIconButtonState createState() => _HeartIconButtonState();
}

class _HeartIconButtonState extends State<HeartIconButton> {
  //TODO CHANGE TO LOCAL DATABASE
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorited ? Icons.favorite : Icons.favorite_border,
        color: isFavorited ? Colors.red : widget.color,
        size: 30,
      ),
      onPressed: () {
        setState(() {
          isFavorited = !isFavorited;
        });
      },
    );
  }
}
