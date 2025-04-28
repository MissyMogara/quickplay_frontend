import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String url; // URL del archivo HLS (.m3u8)

  const VideoPlayerScreen({super.key, required this.url});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    print('URL en prueba: -----------------${widget.url}---------------');

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );

    _videoPlayerController
        .initialize()
        .then((_) {
          if (_videoPlayerController.value.isInitialized) {
            setState(() {});
            print(
              '--------------------Reproductor inicializado.--------------------',
            );
            print(
              '--------------------Aspect ratio: ${_videoPlayerController.value.aspectRatio}----------------------',
            );
            _videoPlayerController.play();
          } else {
            print(
              '-----------Inicialización fallida: el video no fue inicializado correctamente.-----------',
            );
          }
        })
        .catchError((error) {
          print(
            '---------------------Error al inicializar el reproductor: $error----------------------',
          );
        });

    _videoPlayerController.addListener(() {
      final value = _videoPlayerController.value;

      if (value.hasError) {
        print(
          '------------------------Error exacto: ${value.errorDescription}-------------------------------',
        );
      }

      print(
        '------------------------Estado del reproductor: $value-----------------------------',
      );
      print(
        '-------------------¿Está reproducible?: ${value.isInitialized}-------------------------',
      );
      print(
        '--------------------------Duración del video: ${value.duration}---------------------------',
      );
      print(
        '----------------------------------Posición actual: ${value.position}-------------------------',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          _videoPlayerController.value.isInitialized
              ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                child: AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ),
              )
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Inicializando video...'),
                ],
              ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
