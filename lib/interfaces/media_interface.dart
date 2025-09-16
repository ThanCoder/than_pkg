abstract class MediaInterface {
  Future<void> play({required String path, required bool isVideo});
  Future<void> pause();
  Future<void> stop();
  Future<void> resume();
  Future<void> release();
  Future<void> seekTo({required int msec});
  Future<int?> createTexture();
  Future<int?> duration();
  Future<int?> currentPosition();
  Future<int?> videoWidth();
  Future<int?> videoHeight();
  Future<bool> isPlaying();
  Future<void> setVolume({
    required double leftVolume,
    required double rightVolume,
  });
  Future<Map<String, dynamic>> trackInfo();
}
