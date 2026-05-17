/// Frame rate options (how many frames per second)
enum GifFps {
  fps5,
  fps10,
  fps15,
  fps20,
  fps30;

  String get value {
    switch (this) {
      case GifFps.fps5:
        return '5';
      case GifFps.fps10:
        return '10';
      case GifFps.fps15:
        return '15';
      case GifFps.fps20:
        return '20';
      case GifFps.fps30:
        return '30';
    }
  }
}

/// Scale options (resolution of gif)
enum GifScale {
  small, // 320px width
  medium, // 480px width
  large, // 720px width
  original; // keep input size

  String get value {
    switch (this) {
      case GifScale.small:
        return '320:-1';
      case GifScale.medium:
        return '480:-1';
      case GifScale.large:
        return '720:-1';
      case GifScale.original:
        return '-1:-1';
    }
  }
}

extension GifScaleExt on GifScale {}

/// Loop option (how many times gif repeats)
enum GifLoop {
  once,
  infinite;

  String get value {
    switch (this) {
      case GifLoop.once:
        return '1';
      case GifLoop.infinite:
        return '0';
    }
  }
}
