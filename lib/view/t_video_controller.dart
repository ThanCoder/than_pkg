// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:than_pkg/enums/screen_orientation_types.dart';
import 'package:than_pkg/than_pkg.dart';

class TVideoController {
  TVideoController();

  int? textureId;
  int width = 400;
  int height = 400;

  Future<void> init() async {
    textureId = await ThanPkg.android.media.createTexture();
    width = await ThanPkg.android.media.videoWidth() ?? 400;
    height = await ThanPkg.android.media.videoHeight() ?? 400;
  }

  Future<void> play({required String path}) async {
    await ThanPkg.android.media.play(path: path, isVideo: true);
  }

  Future<void> pause() async {
    await ThanPkg.android.media.pause();
  }

  Future<void> resume() async {
    await ThanPkg.android.media.resume();
  }

  Future<int?> duration() async {
    return await ThanPkg.android.media.duration();
  }

  Future<int?> currentPosition() async {
    return await ThanPkg.android.media.currentPosition();
  }

  Future<void> pauseOrResume() async {
    if (await isPlaying()) {
      await pause();
    } else {
      await resume();
    }
  }

  Future<bool> isPlaying() async {
    return await ThanPkg.android.media.isPlaying();
  }

  Future<void> seekTo({required int msec}) async {
    await ThanPkg.android.media.seekTo(msec: msec);
  }

  Stream<int> get currentPositionStream {
    final controller = StreamController<int>();
    Timer.periodic(Duration(seconds: 1), (timer) async {
      try {
        if (await isPlaying()) {
          final pos = await currentPosition();
          controller.add(pos ?? 0);
        } else {
          controller.done;
          timer.cancel();
        }
      } catch (e) {
        timer.cancel();
        controller.addError(e);
      }
    });
    return controller.stream;
  }

  Future<void> dispose() async {
    await ThanPkg.android.media.release();
    ThanPkg.android.app.requestOrientation(
      type: ScreenOrientationTypes.portrait,
    );
    ThanPkg.platform.toggleFullScreen(isFullScreen: false);
    debugPrint('dispose video player');
  }
}
