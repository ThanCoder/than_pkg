class FFmpegAdvanced {
  static final FFmpegAdvanced instance = FFmpegAdvanced._();
  FFmpegAdvanced._();
  factory FFmpegAdvanced() => instance;
}

/**| Function Name             | Purpose                                 | Example FFmpeg Options                                    |
| ------------------------- | --------------------------------------- | --------------------------------------------------------- |
| `combineVideoAndAudio()`  | merge separate video+audio files        | `-i video.mp4 -i audio.mp3 -c:v copy -c:a aac output.mp4` |
| `createVideoFromImages()` | image sequence → video                  | `-framerate 25 -i img%03d.png -c:v libx264 output.mp4`    |
| `streamToRTMP()`          | live stream                             | `-re -i video.mp4 -f flv rtmp://server/live/key`          |
| `recordScreen()`          | record desktop                          | `-f x11grab -i :0.0 -r 30 out.mp4`                        |
| `recordMicrophone()`      | mic audio                               | `-f alsa -i hw:0 out.wav`                                 |
| `muxToContainer()`        | combine multiple streams into container | e.g. `.mkv` muxing                                        |
| `analyzeMediaInfo()`      | get metadata                            | `-i file.mp4` and parse output                            |
 */
