import 'package:flutter/material.dart';
import 'package:than_pkg/enums/screen_orientation_types.dart';
import 'package:than_pkg/than_pkg.dart';
import 'package:than_pkg/view/t_video_controller.dart';

class TVideoView extends StatefulWidget {
  final String path;
  final TVideoController controller;
  const TVideoView({super.key, required this.path, required this.controller});

  @override
  State<TVideoView> createState() => _TVideoViewState();
}

class _TVideoViewState extends State<TVideoView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((_) {
      init();
    });
  }

  void init() async {
    await widget.controller.init();
    await widget.controller.play(path: widget.path);
    isPlaying = true;

    Future.delayed(Duration(milliseconds: 1200)).then((_) async {
      duration = await widget.controller.duration() ?? 0;
    });

    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  bool isShowController = false;
  bool isPlaying = false;
  bool isFullScreen = false;
  int duration = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.controller.textureId == null) {
      return Center(child: CircularProgressIndicator.adaptive());
    }
    return GestureDetector(
      onTap: () {
        // widget.controller.pauseOrResume();
        setState(() {
          isShowController = !isShowController;
        });
      },
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: widget.controller.width / widget.controller.height,
                child: Texture(textureId: widget.controller.textureId!),
              ),
            ),
            Positioned(bottom: 0, left: 0, right: 0, child: _getController()),
          ],
        ),
      ),
    );
  }

  Widget _getController() {
    if (!isShowController) {
      return SizedBox.shrink();
    }
    return Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Column(
        children: [
          // slider
          _getPosSlider(),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await widget.controller.pauseOrResume();
                  isPlaying = await widget.controller.isPlaying();
                  if (!mounted) return;
                  setState(() {});
                },
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 30,
                ),
              ),
              _getDuration(),
              SizedBox(width: 20),
              _getCurrentPosition(),
              Spacer(),
              IconButton(
                onPressed: _toggleFullScreen,
                icon: Icon(
                  isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getPosSlider() {
    return StreamBuilder(
      stream: widget.controller.currentPositionStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final pos = snapshot.data ?? 0;
          // print('dur: $duration - pos: $pos');
          return Slider.adaptive(
            value: pos.toDouble(),
            min: 0.0,
            max: duration.toDouble(),
            onChanged: (value) {},
            onChangeEnd: (double value) {
              // print('dur: $duration - v: ${value.round()}');
              widget.controller.seekTo(msec: value.round());
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _getDuration() {
    return Row(
      children: [
        FutureBuilder(
          future: widget.controller.duration(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              final dur = Duration(milliseconds: data);
              return Text(
                _getParseTime(dur),
                style: TextStyle(color: Colors.grey),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _getCurrentPosition() {
    return StreamBuilder(
      stream: widget.controller.currentPositionStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final pos = snapshot.data!;
          return Text(
            _getParseTime(Duration(milliseconds: pos)),
            style: TextStyle(color: Colors.grey),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  String _getParseTime(Duration dur) {
    return '${(dur.inMinutes % 60).toString().padLeft(2, '0')}M :${(dur.inSeconds % 60).toString().padLeft(2, '0')} S';
  }

  void _toggleFullScreen() {
    isFullScreen = !isFullScreen;
    ThanPkg.platform.toggleFullScreen(isFullScreen: isFullScreen);
    if (isFullScreen) {
      ThanPkg.android.app.requestOrientation(
        type: ScreenOrientationTypes.landscape,
      );
    } else {
      ThanPkg.android.app.requestOrientation(
        type: ScreenOrientationTypes.portrait,
      );
    }
    setState(() {});
  }
}
