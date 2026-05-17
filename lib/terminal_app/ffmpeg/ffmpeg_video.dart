import 'dart:io';

import 'package:than_pkg/terminal_app/ffmpeg/ff_code.dart';
import 'package:than_pkg/terminal_app/ffmpeg/ff_filter.dart';
import 'package:than_pkg/terminal_app/ffmpeg/ffmpeg_process.dart';
import 'package:than_pkg/terminal_app/ffmpeg/gif_code.dart';

class FFmpegVideo {
  static final FFmpegVideo instance = FFmpegVideo._();
  FFmpegVideo._();
  factory FFmpegVideo() => instance;

  ///
  /// ## video to audio
  ///
  Future<void> videoToAudio({
    required String videoPath,
    required String outputPath,
    bool isOverride = true,
    void Function(String data)? onStdout,
    AudioCodec audioCodec = AudioCodec.mp3,
    AudioBitrate bitrate = AudioBitrate.k192,
  }) async {
    final outFile = File(outputPath);
    if (outFile.existsSync() && isOverride) {
      await outFile.delete();
    }
    final arguments = [
      '-i', videoPath,
      StreamIgnore.video.ffmpegOption, // -vn : ignore video
      '-c:a', audioCodec.ffmpegName, // mp3, aac, etc
      '-b:a', bitrate.ffmpegValue, // audio bitrate
      outputPath,
    ];
    await ffmpegStart(arguments: arguments, onStdErrorOut: onStdout);
  }

  ///
  /// ## re-encode video
  ///
  Future<void> videoToVideo({
    required String inputPath,
    required String outputPath,
    bool isOverride = true,
    void Function(String data)? onStdout,
    VideoCodec videoCodec = VideoCodec.h264,
    VideoBitrate bitrate = VideoBitrate.k1000,
    VideoResolution resolution = VideoResolution.r720p,
    List<VideoFilterOption>? filters, // optional
  }) async {
    final outFile = File(outputPath);
    if (outFile.existsSync() && isOverride) {
      await outFile.delete();
    }
    final args = [
      '-i', inputPath,
      '-c:v', videoCodec.ffmpegName,
      '-b:v', bitrate.ffmpegValue,
      '-s', resolution.ffmpegValue,
      '-c:a', 'copy', // audio stream ကို 그대로 retain
    ];
    // filters
    if (filters != null && filters.isNotEmpty) {
      final filterString = filters.map((f) => f.ffmpegString).join(',');
      args.addAll(['-filter:v', filterString]);
    }

    //last add
    args.add(outputPath);

    await ffmpegStart(arguments: args, onStdErrorOut: onStdout);
  }

  ///
  /// ## mp4 → gif
  ///
  Future<void> videoToGif({
    required String inputPath,
    required String outputPath,
    bool isOverride = true,
    void Function(String data)? onStdout,
    GifFps fps = GifFps.fps10,
    GifScale scale = GifScale.medium,
    GifLoop loop = GifLoop.infinite,
    Duration? start, // optional trim start
    Duration? duration, // optional trim length
  }) async {
    final outFile = File(outputPath);
    if (outFile.existsSync() && isOverride) {
      await outFile.delete();
    }
    final args = <String>[];

    if (start != null) {
      args.addAll(['-ss', start.inSeconds.toString()]);
    }

    args.addAll(['-i', inputPath]);

    if (duration != null) {
      args.addAll(['-t', duration.inSeconds.toString()]);
    }

    args.addAll([
      '-vf',
      'fps=${fps.value},scale=${scale.value}:flags=lanczos',
      '-loop',
      loop.value,
      outputPath,
    ]);

    await ffmpegStart(arguments: args, onStdErrorOut: onStdout);
  }

  ///
  /// ##  video cut
  ///
  Future<void> trimVideo({
    required String inputPath,
    required String outputPath,
    bool isOverride = true,
    void Function(String data)? onStdout,
    required Duration start, // where to begin
    required Duration endOrDuration, // either duration or end time
    TrimMode mode = TrimMode.duration,
    TrimVideoCodec codec = TrimVideoCodec.copy,
  }) async {
    final outFile = File(outputPath);
    if (outFile.existsSync() && isOverride) {
      await outFile.delete();
    }
    final args = <String>[
      '-ss',
      start.inSeconds.toString(),
      '-i',
      inputPath,
      mode.flag,
      endOrDuration.inSeconds.toString(),
      '-c:v',
      codec.ffmpegValue,
      '-c:a',
      codec == TrimVideoCodec.copy ? 'copy' : 'aac',
      outputPath,
    ];

    await ffmpegStart(arguments: args, onStdErrorOut: onStdout);
  }

  ///
  /// ##  multiple videos join
  ///## Example
  ///`listFileTextPath` -> `list_file.txt`
  ///```
  /// #wirte down
  ///
  ///file '/path/video1.mp4'
  /// file '/path/video2.mp4'
  ///file '/path/video3.mp4'
  ///
  ///```
  Future<void> mergeVideos({
    required String listFileTextPath, // concat input list file path
    required String outputPath,
    bool isOverride = true,
    void Function(String data)? onStdout,
  }) async {
    final outFile = File(outputPath);
    if (outFile.existsSync() && isOverride) {
      await outFile.delete();
    }
    final args = <String>[
      '-f',
      'concat',
      '-safe',
      '0',
      '-i',
      listFileTextPath,
      '-c',
      'copy',
      outputPath,
    ];

    await ffmpegStart(arguments: args, onStdErrorOut: onStdout);
  }

  ///
  /// ## resize video
  ///
  Future<void> changeResolution({
    required String inputPath,
    required String outputPath,
    required VideoResolutionSize resolution,
    bool isOverride = true,
    void Function(String data)? onStdout,
  }) async {
    final outFile = File(outputPath);
    if (outFile.existsSync() && isOverride) {
      await outFile.delete();
    }
    final args = <String>[
      '-i', inputPath,
      '-vf', 'scale=${resolution.width}:${resolution.height}',
      '-c:a', 'copy', // keep original audio
      outputPath,
    ];

    await ffmpegStart(arguments: args, onStdErrorOut: onStdout);
  }
}

/**| Function Name           | Purpose                  | Example FFmpeg Options                                               |
| ----------------------- | ------------------------ | -------------------------------------------------------------------- |
| `videoToVideo()`        | re-encode video          | `-i input.mp4 -c:v h264 -b:v 1500k output.mp4`                       |
| `videoToGif()`          | mp4 → gif                | `-i input.mp4 -vf "fps=10,scale=480:-1" output.gif`                  |
| `trimVideo()`           | video cut                | `-ss 00:00:10 -t 00:00:20 -c copy`                                   |
| `mergeVideos()`         | multiple videos join     | concat demuxer                                                       |
| `changeResolution()`    | resize video             | `-vf "scale=1280:720"`                                               |
| `changeFrameRate()`     | FPS change               | `-r 30`                                                              |
| `extractFrames()`       | frame-per-second extract | `-vf fps=1 frame_%03d.png`                                           |
| `overlayImageOnVideo()` | watermark/logo           | `-i video.mp4 -i logo.png -filter_complex "overlay=10:10"`           |
| `addTextToVideo()`      | draw text                | `-vf "drawtext=text='Hello':x=100:y=50:fontsize=24:fontcolor=white"` |
| `rotateVideo()`         | rotate 90/180/270        | `-vf "transpose=1"`                                                  |
| `reverseVideo()`        | play backward            | `-vf reverse`                                                        |
 */
