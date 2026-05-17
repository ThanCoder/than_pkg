import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

@Deprecated(
  'Use `dart_core_extensions` instead.This extension will be removed in version V6.0.0',
)
extension DatetimeExtension on DateTime {
  String toParseTime({String pattern = 'hh:mm a dd/MM/yyyy'}) {
    return DateFormat(pattern).format(this);
  }

  String toTimeAgo() {
    return timeago.format(this);
  }
}
