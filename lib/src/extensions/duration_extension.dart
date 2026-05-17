@Deprecated(
  'Use `dart_core_extensions` instead.This extension will be removed in version V6.0.0',
)
extension DurationExtension on Duration {
  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
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
