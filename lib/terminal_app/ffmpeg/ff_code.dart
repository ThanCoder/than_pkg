enum AudioCodec {
  mp3,
  aac,
  flac,
  wav,
  opus;

  String get ffmpegName {
    switch (this) {
      case mp3:
        return 'mp3';
      case aac:
        return 'aac';
      case flac:
        return 'flac';
      case wav:
        return 'wav';
      case opus:
        return 'opus';
    }
  }
}

enum VideoCodec {
  h264,
  h265,
  mpeg4;

  ///```
  ///
  ///``
  String get ffmpegName {
    switch (this) {
      case h264:
        return 'libx264';
      case h265:
        return 'libx265';
      case mpeg4:
        return 'mpeg4';
    }
  }
}

enum StreamIgnore {
  video,
  audio,
  subtitle,
  data;

  /// test
  ///
  String get ffmpegOption {
    switch (this) {
      case video:
        return '-vn';
      case audio:
        return '-an';
      case subtitle:
        return '-sn';
      case data:
        return '-dn';
    }
  }
}

enum AudioBitrate { k64, k128, k192, k256, k320 }

extension AudioBitrateExt on AudioBitrate {
  String get ffmpegValue {
    switch (this) {
      case AudioBitrate.k64:
        return '64k';
      case AudioBitrate.k128:
        return '128k';
      case AudioBitrate.k192:
        return '192k';
      case AudioBitrate.k256:
        return '256k';
      case AudioBitrate.k320:
        return '320k';
    }
  }
}

enum VideoResolution {
  r480p,
  r720p,
  r1080p,
  r4k;

  String get ffmpegValue {
    switch (this) {
      case VideoResolution.r480p:
        return '640x480';
      case VideoResolution.r720p:
        return '1280x720';
      case VideoResolution.r1080p:
        return '1920x1080';
      case VideoResolution.r4k:
        return '3840x2160';
    }
  }
}

enum VideoBitrate {
  k500,
  k1000,
  k1500,
  k2000;

  String get ffmpegValue {
    switch (this) {
      case VideoBitrate.k500:
        return '500k';
      case VideoBitrate.k1000:
        return '1000k';
      case VideoBitrate.k1500:
        return '1500k';
      case VideoBitrate.k2000:
        return '2000k';
    }
  }
}

enum OutputFormat {
  mp3,
  aac,
  flac,
  wav,
  mp4,
  mkv,
  mov;

  String get ffmpegName {
    switch (this) {
      case OutputFormat.mp3:
        return 'mp3';
      case OutputFormat.aac:
        return 'aac';
      case OutputFormat.flac:
        return 'flac';
      case OutputFormat.wav:
        return 'wav';
      case OutputFormat.mp4:
        return 'mp4';
      case OutputFormat.mkv:
        return 'mkv';
      case OutputFormat.mov:
        return 'mov';
    }
  }
}

enum SubtitleCodec {
  movText, // MP4 container အတွက်
  srt; // MKV container အတွက်

  String get ffmpegName {
    switch (this) {
      case SubtitleCodec.movText:
        return 'mov_text';
      case SubtitleCodec.srt:
        return 'srt';
    }
  }
}

/// Trim Mode — duration အလိုက် သတ်မှတ်မလား end time အထိလား
enum TrimMode {
  duration, // use -t
  endTime; // use -to

  String get flag => this == TrimMode.duration ? '-t' : '-to';
}

/// Video codec option (copy = no re-encode)
enum TrimVideoCodec {
  copy,
  h264,
  h265,
  vp9;

  String get ffmpegValue {
    switch (this) {
      case TrimVideoCodec.copy:
        return 'copy';
      case TrimVideoCodec.h264:
        return 'libx264';
      case TrimVideoCodec.h265:
        return 'libx265';
      case TrimVideoCodec.vp9:
        return 'libvpx-vp9';
    }
  }
}
