extension DurationExtension on Duration {
  String getAutoTimeLabel({
    String hourLable = 'h',
    String minutesLable = 'm',
    String secondsLable = 's',
    String miliSecondsLable = 'ms',
  }) {
    if (inMinutes > 60) {
      return '$inHours $hourLable';
    }
    if (inSeconds > 60) {
      return '$inMinutes $minutesLable';
    }
    if (inMilliseconds >= 1000) {
      return '$inSeconds $secondsLable';
    }

    return '$inMilliseconds $miliSecondsLable';
  }
}
