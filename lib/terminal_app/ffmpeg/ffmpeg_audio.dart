import 'dart:io';

import 'package:than_pkg/terminal_app/ffmpeg/ffmpeg_process.dart';

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