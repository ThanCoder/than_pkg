import 'package:flutter/material.dart';
import 'package:than_pkg/view/t_video_controller.dart';
import 'package:than_pkg/view/t_video_view.dart';

class VideoScreen extends StatefulWidget {
  final String path;
  const VideoScreen({super.key, required this.path});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final controller = TVideoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Video Player'),
      // ),
      body: TVideoView(
        path: widget.path,
        controller: controller,
      ),
    );
  }
}
