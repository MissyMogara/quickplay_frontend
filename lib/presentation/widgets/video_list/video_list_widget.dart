import 'package:flutter/material.dart';
import 'package:quickplay_frontend/domain/entities/video.dart';
import 'package:quickplay_frontend/config/helpers/get_videos.dart';
import 'package:quickplay_frontend/presentation/widgets/video_list/video_player_screen.dart';

class VideoListWidget extends StatefulWidget {
  const VideoListWidget({super.key});

  @override
  _VideoListWidgetState createState() => _VideoListWidgetState();
}

class _VideoListWidgetState extends State<VideoListWidget> {
  // Inicializar 'videoListFuture' con un valor predeterminado
  late Future<List<Video>> videoListFuture = getVideos();

  @override
  void initState() {
    super.initState();
    // Asignar 'getVideos()' durante la inicialización
    videoListFuture = getVideos();
  }

  @override
  Widget build(BuildContext context) {
    String route = "https://145d-31-221-187-207.ngrok-free.app/api/videos/";
    print("VideoURL: " + route);

    return FutureBuilder<List<Video>>(
      future: videoListFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final videoList = snapshot.data!;
          return ListView.builder(
            itemCount: videoList.length,
            itemBuilder: (context, index) {
              final video = videoList[index];
              String completeRoute = route + video.name;
              return VideoPlayerScreen(url: completeRoute);
            },
          );
        } else {
          return const Center(child: Text('No hay videos disponibles.'));
        }
      },
    );
  }
}
