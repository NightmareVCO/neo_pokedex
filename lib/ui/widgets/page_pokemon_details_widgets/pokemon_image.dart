import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:neo_pokedex/utils/audio_utils.dart';

class PokemonImage extends StatefulWidget {
  final String imageUrl;
  final String cryUrl;
  final String id;

  const PokemonImage(
      {super.key,
      required this.imageUrl,
      required this.cryUrl,
      required this.id});

  @override
  // ignore: library_private_types_in_public_api
  _PokemonImageState createState() => _PokemonImageState();
}

class _PokemonImageState extends State<PokemonImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<String> getMp3(String oggUrl) async {
    if (Platform.isIOS) {
      var url = convertOggToMp3(oggUrl);
      return url;
    }
    return "default_url";
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0.8,
      upperBound: 1.0,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() async {
    if (Platform.isIOS) {
      String mp3Url = await getMp3(widget.cryUrl);

      if (mp3Url.isNotEmpty) {
        await _audioPlayer.play(UrlSource(mp3Url, mimeType: 'audio/mp3'));
      }
    } else {
      _audioPlayer.play(UrlSource(widget.cryUrl, mimeType: 'audio/ogg'));
    }
    _controller.forward().then((value) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: ScaleTransition(
          scale: _animation,
          child: Hero(
            tag: widget.id,
            child: Image.network(
              widget.imageUrl,
              width: 220,
              height: 220,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return const Center(child: Icon(Icons.error));
              },
            ),
          )),
    );
  }
}
