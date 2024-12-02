import 'dart:io';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart'; // Asegúrate de tener la última versión
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';

class ShareIconButton extends StatelessWidget {
  final Color color;
  final ScreenshotController screenshotController;

  const ShareIconButton({
    super.key,
    required this.color,
    required this.screenshotController,
  });

  Future<void> _shareScreenshot(BuildContext context) async {
    try {
      final image = await screenshotController.capture();
      if (image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al capturar la pantalla')),
        );
        return;
      }
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/screenshot.png';

      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(image);

      final xfile = XFile(imagePath);

      await Share.shareXFiles(
        [xfile],
        text: '¡Mira este pokemon tan chulo!',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al compartir la captura: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.share, color: color),
      onPressed: () => _shareScreenshot(context),
      tooltip: 'Compartir Pantalla',
    );
  }
}
