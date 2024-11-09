import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

const apiKey =
    'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNDMwMDg4MmY5ZTkzMWYyYmJkNzY0Njk4YzRkMzg5ZThlMDIwNWNlODg3YmJiNWE3YTUzZDc4ODA5NzMxM2IyM2ZkOGY1NDJhZTFmNzJjNzciLCJpYXQiOjE3MzExMjQyMTYuNDI2MDA4LCJuYmYiOjE3MzExMjQyMTYuNDI2MDA5LCJleHAiOjQ4ODY3OTc4MTYuNDIyMjA4LCJzdWIiOiI3MDE0MjI3MSIsInNjb3BlcyI6WyJ1c2VyLnJlYWQiLCJ1c2VyLndyaXRlIiwidGFzay5yZWFkIiwidGFzay53cml0ZSIsIndlYmhvb2sucmVhZCIsIndlYmhvb2sud3JpdGUiLCJwcmVzZXQucmVhZCIsInByZXNldC53cml0ZSJdfQ.H8cVHo0Se77fc4vWyjo8qd7gyo_CqCejWRmd2KtCXvBpwNLjT2ZKo4NDVuRRs9eXmYXZyNBG6-uQ5NeuY3oeUtu_j01m8olHqoDe10ou8tIFapJQdXQf0rHfHhxlQbJGw261gQuE4Lsi4R449bnwp_iMIH3PKB09wMQIjH6E3I35LwH-4E_-8K8E0pm0MsCy-iM0NOYJkVmxx2XKY8LRU-3Y3AIBmJZNL_wFICb25jtEUxXgoJ3g8yQ3DxaPL2nR853T3A6rQrbzW_KHQeiz7tA9VuoVBZl27QblrfMnh5iRvWDUxk9VoNifLfRrn1awL4HJRwNlRPT62GXewOWXkvAR4WsqD-T6Gpkpog-E54CO7EnL_aq08NEz2U8-sqlGgIvTwb_xjWQnJo58q5GgFHcYe2OdQH3Xor9a3e-6FU_vhf3T8h-9bPzxxD0tLpAVKV7qxWDKNLPrdIcvtqy-XV6Zy1BJ90IVbKKUs6HqXwP2WAEu1lGEZSeHj4dzuOYvoClCfgRUjokqHOe9mpvC7O5_h5YCmUx7iWbO3p1pUCJoQ2_7_nLQ0L9ygpdrP4h_jrxfpwo6qfUse-EYd3xvUw1LcIVmWFV135so7k1W_cQkKLJXBLCtAid4VO6f9fK1ZmZgLP3TRU0nDWaAqmA_F30aLNl2xQmff72UWIjJvlM';

const apiKey2 =
    'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMTNiNWQ1YzVhODNmMDgyOGJmMjI5MmRiNTUzZjk1NzY2N2NmZDllNzQzMmUxZjVmN2VlNTFhM2RjOTIzYTA1NTljODQ0MzEwNjU0MzFlYTkiLCJpYXQiOjE3MzExMjkzNzcuMjAwODAzLCJuYmYiOjE3MzExMjkzNzcuMjAwODA1LCJleHAiOjQ4ODY4MDI5NzcuMTk3MzE3LCJzdWIiOiI3MDE0MjY2MCIsInNjb3BlcyI6WyJwcmVzZXQucmVhZCIsInVzZXIucmVhZCIsInVzZXIud3JpdGUiLCJ0YXNrLnJlYWQiLCJ0YXNrLndyaXRlIiwid2ViaG9vay5yZWFkIiwid2ViaG9vay53cml0ZSIsInByZXNldC53cml0ZSJdfQ.jnTpgybJjX3EDfr-vmBso61A2KRSdtES489CaOouhxgI-6F5sahybhmz8fiK8H7LVam4wHDbm8LgMTKS5yB0r-m_SddeKM6V0DKSnCoQDRCjRqORyVGpHe4TPyZ4bgwCRF9TVrZZrHmpwUNeW_HM306hTQcvmEwnkyaOaINdQ3C6OCc9XeICzv1PjLFNiH3UZn8y1ZRI7rnNYVFBlO7GXTgKHTNj3RsRfdUcTOI5LSdu6cJ6i0ocghgSP9OhHUzxjHfVnzxQOYqrK-m2krVNg2SpxbRD6kNe4bQopW1AJzKWscSHOmCnGH2LPVqoSLns03OBs2hxZMqW24vFMXlBFOqGBrhDYmadJwwchXbHS2bBqiLhcSNs3Fu2BGT20HJiMDZbRfkdwpvXDh64Sm8QFilCaz-ND57JC9_K5UcHl89zILURJjfSKMTCnhin5beIaqd9h890iVUheTFNshr1ZDAeA67B3EfPZ1Fp7AsVAU9dfcnjebgaMa_BW-K_lSRBacFrrdtzUkMeHJDjbrEUpfCfVWvyiZJuJoFq-DH-99JeIeWKGe8bo3XY8IxqBsBdxZJuIwF7ks4HzW9stzVUOqVszPARIcuUlFkp41rFAzrHLL07kJMaOwBRmD7ZPO2dHR7PhLyaKoQnEbPDTP6LyJ4rLDbCtlPa6gQhfzEgx8g';

Future<String> convertOggToMp3(String oggUrl) async {
  final prefs = await SharedPreferences.getInstance();

  // Verificar si ya existe una URL MP3 almacenada para este OGG
  String? storedMp3Url = prefs.getString(oggUrl);
  if (storedMp3Url != null) {
    return storedMp3Url;
  }

  // Verificar si hay un jobId almacenado para este OGG
  String? storedJobId = prefs.getString('${oggUrl}_jobId');
  String? mp3Url;

  if (storedJobId != null) {
    // Si existe un jobId, verificar el estado del trabajo existente
    final jobStatusResponse = await http.get(
      Uri.parse('https://api.cloudconvert.com/v2/jobs/$storedJobId'),
      headers: {
        'Authorization': apiKey2,
      },
    );

    if (jobStatusResponse.statusCode == 200) {
      final jobData = json.decode(jobStatusResponse.body);
      if (jobData['data']['status'] == 'finished') {
        // Obtener la URL del archivo MP3
        mp3Url = jobData['data']['tasks']
                .firstWhere((task) => task['name'] == 'export-mp3')['result']
            ['files'][0]['url'];
        // Guardar la URL en SharedPreferences para futuras consultas
        prefs.setString(oggUrl, mp3Url!);
        return mp3Url;
      } else {
        return convertOggToMp3(oggUrl);
      }
    } else {
      return convertOggToMp3(oggUrl);
    }
  }

  // Si no hay jobId almacenado o el trabajo no está terminado, crear un nuevo trabajo
  final url = Uri.parse('https://api.cloudconvert.com/v2/jobs');
  final filename = oggUrl.split('/').last;

  final response = await http.post(
    url,
    headers: {
      'Authorization': apiKey2,
      'Content-Type': 'application/json',
    },
    body: json.encode({
      "tasks": {
        "ogg-import": {
          "operation": "import/url",
          "url": oggUrl,
          "filename": "$filename.ogg"
        },
        "ogg-to-mp3": {
          "operation": "convert",
          "input_format": "ogg",
          "output_format": "mp3",
          "engine": "ffmpeg",
          "input": ["ogg-import"],
          "audio_codec": "mp3",
          "audio_qscale": 0
        },
        "export-mp3": {
          "operation": "export/url",
          "input": ["ogg-to-mp3"],
          "inline": true,
          "archive_multiple_files": false
        }
      },
      "tag": "jobbuilder"
    }),
  );

  if (response.statusCode != 400) {
    final data = json.decode(response.body);
    if (response.statusCode == 402) {
      return '';
    }

    String jobId = data['data']['id'];

    // Guardar el jobId en SharedPreferences para futuras verificaciones
    prefs.setString('${oggUrl}_jobId', jobId);

    // Esperar un poco antes de verificar el estado del trabajo
    await Future.delayed(const Duration(seconds: 5));

    final jobStatusResponse = await http.get(
      Uri.parse('https://api.cloudconvert.com/v2/jobs/$jobId'),
      headers: {
        'Authorization': apiKey2,
      },
    );

    if (jobStatusResponse.statusCode == 201) {
      final jobData = json.decode(jobStatusResponse.body);

      // Verificar si el trabajo ha finalizado
      if (jobData['data']['status'] == 'finished') {
        mp3Url = jobData['data']['tasks']
                .firstWhere((task) => task['name'] == 'export-mp3')['result']
            ['files'][0]['url'];

        // Guardar la URL en SharedPreferences
        prefs.setString(oggUrl, mp3Url!);

        return mp3Url; // Retornar la URL del archivo MP3
      } else {
        return convertOggToMp3(oggUrl);
      }
    } else {
      return convertOggToMp3(oggUrl);
    }
  } else {
    return convertOggToMp3(oggUrl);
  }
}
