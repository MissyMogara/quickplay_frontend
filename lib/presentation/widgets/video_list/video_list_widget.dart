import 'package:flutter/material.dart';

class VideoListWidget extends StatefulWidget {
  const VideoListWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VideoListWidgetState createState() => _VideoListWidgetState();
}

class _VideoListWidgetState extends State<VideoListWidget> {
  @override
  Widget build(BuildContext context) {
    List<String> videoList = [
      'Video 1',
      'Video 2',
      'Video 3',
      'Video 4',
      'Video 5',
    ];

    return ListView.builder(
      itemCount: videoList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Center(child: Text(videoList[index])),
          onTap: () {
            // Handle video tap
            print('Tapped on ${videoList[index]}');
          },
        );
      },
    );
  }
}
