enum AudioFilter {
  volume,
  equalizer,
  aresample;

  String get ffmpegName {
    switch (this) {
      case AudioFilter.volume:
        return 'volume';
      case AudioFilter.equalizer:
        return 'equalizer';
      case AudioFilter.aresample:
        return 'aresample';
    }
  }
}

enum VideoFilter {
  scale,
  crop,
  rotate,
  fps;

  String get ffmpegName {
    switch (this) {
      case VideoFilter.scale:
        return 'scale';
      case VideoFilter.crop:
        return 'crop';
      case VideoFilter.rotate:
        return 'rotate';
      case VideoFilter.fps:
        return 'fps';
    }
  }
}

class VideoFilterOption {
  final VideoFilter filter;
  final String value; // ex: '1280:720' or '30' or 'iw/2:ih/2'
  /// ## Example
  /// ```
  /// VideoFilterOption(filter: VideoFilter.scale, value: '1280:720'),
  /// VideoFilterOption(filter: VideoFilter.fps, value: '30')
  /// ```
  /// ## Explanation:
  ///```Bash
  /// scale=1280:720 → video resolution change
  /// fps=30 → frame rate adjust
  /// Comma-separated filters (filter1,filter2) → FFmpeg chain filters automatically
  /// ```
  /// ## Tips:
  /// ```Bash
  /// Filters can be combined: e.g., scale=1280:720,fps=30,rotate=PI/2
  /// Audio filters can be added similarly using -filter:a
  ///
  /// ```
  VideoFilterOption({required this.filter, required this.value});

  String get ffmpegString => '${filter.ffmpegName}=$value';
}

class VideoResolutionSize {
  // p360(640, 360),
  // p480(854, 480),
  // p720(1280, 720),
  // p1080(1920, 1080);

  final int width;
  final int height;
  const VideoResolutionSize(this.width, this.height);

  static const p360 = VideoResolutionSize(640, 360);
  static const p480 = VideoResolutionSize(854, 480);
  static const p720 = VideoResolutionSize(1280, 720);
  static const p1080 = VideoResolutionSize(1920, 1080);
}
