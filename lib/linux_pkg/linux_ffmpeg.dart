import 'package:than_pkg/terminal_app/ffmpeg/ffmpeg_audio.dart';
import 'package:than_pkg/terminal_app/ffmpeg/ffmpeg_ffprob.dart';
import 'package:than_pkg/terminal_app/ffmpeg/ffmpeg_video.dart';

class LinuxFFmpeg {
  static final LinuxFFmpeg instance = LinuxFFmpeg._();
  LinuxFFmpeg._();
  factory LinuxFFmpeg() => instance;

  FFmpegVideo get video => FFmpegVideo.instance;
  FFmpegAudio get audio => FFmpegAudio.instance;
  FFmpegFFprob get ffprob => FFmpegFFprob.instance;
}
