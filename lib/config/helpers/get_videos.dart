import 'package:http/http.dart' as http;
import 'package:quickplay_frontend/domain/entities/video.dart';
import 'dart:convert';

Future<List<Video>> getVideos() async {
  final url = Uri.parse(
    'https://145d-31-221-187-207.ngrok-free.app/api/videos',
  );
  int retries = 3; // Número de reintentos
  const timeoutDuration = Duration(seconds: 15); // Tiempo de espera

  for (int i = 0; i < retries; i++) {
    try {
      print('Intentando obtener los videos. Intento ${i + 1} de $retries');

      final response = await http.get(url).timeout(timeoutDuration);

      if (response.statusCode == 200) {
        print('Fetch exitoso. Datos recibidos: ${response.body}');
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Video.fromJson(json)).toList();
      } else {
        print('Error al realizar el fetch: ${response.reasonPhrase}');
        throw Exception('Error al cargar los videos: ${response.reasonPhrase}');
      }
    } on Exception catch (e) {
      print('Error: $e');
      if (i == retries - 1) {
        throw Exception(
          'No se pudo conectar al servidor tras varios intentos.',
        );
      }
    }
  }

  return []; // Retorno predeterminado en caso de fallo
}
