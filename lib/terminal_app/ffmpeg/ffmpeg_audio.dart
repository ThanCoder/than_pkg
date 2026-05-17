import 'dart:convert';
import 'dart:io';

import 'package:than_pkg/terminal_app/ffmpeg/ffmpeg_process.dart';
import 'package:than_pkg/terminal_app/ffmpeg/audio_metadata.dart';

class FFmpegAudio {
  static final FFmpegAudio instance = FFmpegAudio._();
  FFmpegAudio._();
  factory FFmpegAudio() => instance;
  Future<void> audioToAudio({
    required String inputPath,
    required String outputPath,
    bool isOverride = true,
    void Function(String data)? onStdout,
  }) async {
    final outFile = File(outputPath);
    if (outFile.existsSync() && isOverride) {
      await outFile.delete();
    }
    final arguments = ['-i', inputPath, outputPath];
    await ffmpegStart(arguments: arguments, onStdErrorOut: onStdout);
  }

  ///
  ///  ## Audio Metadata
  ///
  Future<AudioMetadata> getAudioMetadata(String audioPath) async {
    //ffprobe -v quiet -show_entries format_tags -of json
    final result = await ffprobeRun(
      arguments: [
        '-v',
        'quiet',
        '-show_entries',
        'format_tags',
        '-of',
        'json',
        audioPath,
      ],
    );

    if (result.exitCode != 0) {
      throw Exception('ffprobe failed: ${result.stderr}');
    }

    final jsonData = jsonDecode(result.stdout);

    // format.tags ထဲက metadata ပဲ return လုပ်တာ
    final tags = jsonData['format']?['tags'] as Map<String, dynamic>? ?? {};

    return AudioMetadata.fromMap(tags);
  }

  ///
  /// ## Audio Metadata Edit
  ///
  Future<void> editAudioMetadata({
    required String inputPath,
    required String outputPath,
    required AudioMetadata metadata,
    bool isOverride = true,
  }) async {
    final outFile = File(outputPath);
    if (outFile.existsSync() && isOverride) {
      await outFile.delete();
    }

    final args = <String>['-i', inputPath];

    if (metadata.title != null) {
      args.addAll(['-metadata', 'title=${metadata.title}']);
    }
    if (metadata.artist != null) {
      args.addAll(['-metadata', 'artist=${metadata.artist}']);
    }
    if (metadata.album != null) {
      args.addAll(['-metadata', 'album=${metadata.album}']);
    }
    if (metadata.genre != null) {
      args.addAll(['-metadata', 'genre=${metadata.genre}']);
    }
    if (metadata.date != null) {
      args.addAll(['-metadata', 'date=${metadata.date}']);
    }
    if (metadata.comment != null) {
      args.addAll(['-metadata', 'comment=${metadata.comment}']);
    }

    // args.addAll(['-c', 'copy', outputPath]);
    args.addAll(['-id3v2_version', '3', outputPath]);

    await ffmpegRun(arguments: args);
  }

  // Future<void> extractAudio() async {}
  // Future<void> mergeAudios() async {}
  // Future<void> trimAudio() async {}
  // Future<void> changeAudioSpeed() async {}
  // Future<void> changeAudioPitch() async {}
  // Future<void> normalizeAudio() async {}
  // Future<void> addAudioToVideo() async {}
}


/**| Function Name        | Purpose                         | Example FFmpeg Options                                           |
| -------------------- | ------------------------------- | ---------------------------------------------------------------- |
| `audioToAudio()`     | audio format convert            | `-i input.wav -c:a mp3 output.mp3`                               |
| `extractAudio()`     | video ထဲက audio ကိုတစ်ခုပဲထုတ်  | `-i video.mp4 -vn -acodec copy audio.aac`                        |
| `mergeAudios()`      | audio files တွေကို ပေါင်း       | concat demuxer or filter_complex                                 |
| `trimAudio()`        | time-based cut                  | `-ss 00:00:10 -t 00:00:30`                                       |
| `changeAudioSpeed()` | playback speed change           | `-filter:a "atempo=1.5"`                                         |
| `changeAudioPitch()` | pitch shift                     | `-filter:a "asetrate=44100*1.2,aresample=44100"`                 |
| `normalizeAudio()`   | volume normalize                | `-filter:a loudnorm`                                             |
| `addAudioToVideo()`  | external audio ကို video ထဲထည့် | `-i video.mp4 -i music.mp3 -c:v copy -c:a aac -map 0:v -map 1:a` |
 */