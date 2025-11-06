import 'dart:convert';
import 'package:than_pkg/terminal_app/ffmpeg/ffmpeg_process.dart';

class FFmpegFFprob {
  static final FFmpegFFprob instance = FFmpegFFprob._();
  FFmpegFFprob._();
  factory FFmpegFFprob() => instance;

  /// ## Infomation
  /// ### (duration, bitrate, codec, frame rate, resolution, etc.)
  ///
  Future<Map<String, dynamic>> getMediaInfo(String inputPath) async {
    final result = await ffprobeRun(
      arguments: [
        '-v',
        'quiet',
        '-print_format',
        'json',
        '-show_format',
        '-show_streams',
        inputPath,
      ],
    );

    if (result.exitCode != 0) {
      throw Exception('ffprobe failed: ${result.stderr}');
    }

    return jsonDecode(result.stdout);
  }

  ///
  /// ## Audio thumbnail add
  ///
  // Future<void> addAudioThumbnail({
  //   required String audioPath,
  //   required String imagePath,
  //   required String outputPath,
  //   bool isOverride = true,
  //   void Function(String data)? onStdout,
  // }) async {
  //   final outFile = File(outputPath);
  //   if (outFile.existsSync() && isOverride) {
  //     await outFile.delete();
  //   }

  //   final args = <String>[
  //     '-i',
  //     audioPath,
  //     '-i',
  //     imagePath,
  //     '-map',
  //     '0:a',
  //     '-map',
  //     '1',
  //     '-c',
  //     'copy',
  //     '-id3v2_version',
  //     '3',
  //     '-metadata:s:v',
  //     'title=Album cover',
  //     '-metadata:s:v',
  //     'comment=Cover (front)',
  //     outputPath,
  //   ];

  //   await ffprobeStart(arguments: args, onStdErrorOut: onStdout);
  // }

  ///
  /// ## Audio thumbnail extract
  ///
  // Future<void> extractAudioThumbnail({
  //   required String audioPath,
  //   required String outImagePath,
  //   bool isOverride = true,
  //   void Function(String data)? onStdout,
  // }) async {
  //   final outFile = File(outImagePath);
  //   if (outFile.existsSync() && isOverride) {
  //     await outFile.delete();
  //   }

  //   final args = <String>['-i', audioPath, outImagePath];

  //   await ffprobeStart(arguments: args, onStdErrorOut: onStdout);
  // }

  ///
  /// ## Audio thumbnail delete
  ///
  // Future<void> deleteAudioThumbnail({
  //   required String audioPath,
  //   required String outputPath,
  //   bool isOverride = true,
  //   void Function(String data)? onStdout,
  // }) async {
  //   final outFile = File(outputPath);
  //   if (outFile.existsSync() && isOverride) {
  //     await outFile.delete();
  //   }
  //   //ffmpeg -i input.mp3 -vn -c copy output.mp3
  //   final args = <String>['-i', audioPath, '-vn', '-c', 'copy', outputPath];

  //   await ffprobeStart(arguments: args, onStdErrorOut: onStdout);
  // }
}
