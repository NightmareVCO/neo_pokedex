import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ImageCacheManager {
  static Future<Uint8List?> getImage(String url, String id) async {
    try {
      final cacheDir = await getTemporaryDirectory();
      final file = File('${cacheDir.path}/pokemon_$id.png');

      if (await file.exists()) {
        return file.readAsBytes();
      }

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        return response.bodyBytes;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<void> clearCache() async {
    final cacheDir = await getTemporaryDirectory();
    if (await cacheDir.exists()) {
      await cacheDir.delete(recursive: true);
    }
  }
}
