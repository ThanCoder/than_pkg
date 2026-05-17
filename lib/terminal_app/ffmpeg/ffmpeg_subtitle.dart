import 'dart:io';

import 'package:than_pkg/terminal_app/ffmpeg/ff_code.dart';
import 'package:than_pkg/terminal_app/ffmpeg/ffmpeg_process.dart';

class FFmpegSubtitle {
  static final FFmpegSubtitle instance = FFmpegSubtitle._();
  FFmpegSubtitle._();
  factory FFmpegSubtitle() => instance;

  Future<void> addSubtitleToVideo({
    required String videoPath,
    required String subtitlePath,
    required String outputPath,
    bool isOverride = true,
    void Function(String data)? onStdout,
    VideoCodec videoCodec = VideoCodec.h264,
    VideoBitrate bitrate = VideoBitrate.k1000,
    SubtitleCodec subtitleCodec = SubtitleCodec.movText,
  }) async {
    final outFile = File(outputPath);
    if (outFile.existsSync() && isOverride) {
      await outFile.delete();
    }

    final args = [
      '-i', videoPath, // main video
      '-i', subtitlePath, // subtitle file
      '-c:v', videoCodec.ffmpegName,
      '-b:v', bitrate.ffmpegValue,
      '-c:a', 'copy', // original audio retain
      '-c:s', subtitleCodec.ffmpegName, // subtitle codec
      '-map', '0:v', // video stream from first input
      '-map', '0:a?', // audio stream if exists
      '-map', '1:s', // subtitle stream from second input
      outputPath,
    ];

    await ffmpegStart(arguments: args, onStdErrorOut: onStdout);
  }
}

/**| Function Name             | Purpose                      | Example FFmpeg Options                  |
| ------------------------- | ---------------------------- | --------------------------------------- |
| `addSubtitleToVideo()`    | embed .srt                   | `-i video.mp4 -i sub.srt -c:s mov_text` |
| `extractSubtitle()`       | extract subtitle stream      | `-map 0:s:0 subs.srt`                   |
| `burnSubtitle()`          | hardcode subtitle into video | `-vf subtitles=sub.srt`                 |
| `convertSubtitleFormat()` | .ass ↔ .srt                  | use `ffmpeg -i input.ass output.srt`    |
 */
