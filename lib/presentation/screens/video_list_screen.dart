import 'package:flutter/material.dart';
import 'package:quickplay_frontend/presentation/widgets/video_list/video_list_widget.dart';

class VideoListScreen extends StatelessWidget {
  const VideoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de videos')),
      body: Center(child: VideoListWidget()),
    );
  }
}
