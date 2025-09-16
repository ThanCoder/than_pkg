import 'package:flutter/services.dart';
import 'package:than_pkg/interfaces/media_interface.dart';

class AndroidMediaUtil extends MediaInterface {
  static final AndroidMediaUtil instance = AndroidMediaUtil._();
  AndroidMediaUtil._();
  factory AndroidMediaUtil() => instance;

  final _channel = const MethodChannel('than_pkg');
  // final _eventChannel = const EventChannel('mediaUtil/progress');
  final _name = 'mediaUtil';

  @override
  Future<int?> createTexture() async {
    return await _channel.invokeMethod<int>('$_name/createTexture');
  }

  @override
  Future<int?> duration() async {
    return await _channel.invokeMethod<int>('$_name/duration');
  }

  @override
  Future<int?> currentPosition() async {
    return await _channel.invokeMethod<int>('$_name/currentPosition');
  }


  @override
  Future<bool> isPlaying() async {
    final res = await _channel.invokeMethod<bool>('$_name/isPlaying');
    return res ?? false;
  }

  @override
  Future<void> pause() async {
    await _channel.invokeMethod('$_name/pause');
  }

  @override
  Future<void> play({required String path, required bool isVideo}) async {
    await _channel.invokeMethod('$_name/play', {
      'path': path,
      'isVideo': isVideo,
    });
  }

  @override
  Future<void> release() async {
    await _channel.invokeMethod('$_name/release');
  }

  @override
  Future<void> resume() async {
    await _channel.invokeMethod('$_name/resume');
  }

  @override
  Future<void> seekTo({required int msec}) async {
    await _channel.invokeMethod('$_name/seekTo', {'mesc': msec});
  }

  @override
  Future<void> setVolume({
    required double leftVolume,
    required double rightVolume,
  }) async {
    await _channel.invokeMethod('$_name/seekTo', {
      'leftVolume': leftVolume,
      'rightVolume': rightVolume,
    });
  }

  @override
  Future<void> stop() async {
    await _channel.invokeMethod('$_name/stop');
  }

  @override
  Future<Map<String, dynamic>> trackInfo() async {
    final res = await _channel.invokeMethod<Map>('$_name/trackInfo');
    return Map<String, dynamic>.from(res ?? {});
  }

  @override
  Future<int?> videoHeight() async {
    return await _channel.invokeMethod<int>('$_name/videoHeight');
  }

  @override
  Future<int?> videoWidth() async {
    return await _channel.invokeMethod<int>('$_name/videoWidth');
  }
}
