import 'package:http/http.dart' as http;
import 'package:quickplay_frontend/domain/entities/video.dart';
import 'dart:convert';

Future<List<Video>> getVideos() async {
  final url = Uri.parse(
    'https://1ca0-31-221-147-242.ngrok-free.app/api/videos',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);

    return jsonData.map((json) => Video.fromJson(json)).toList();
  } else {
    throw Exception('Error al cargar los videos: ${response.reasonPhrase}');
  }
}
