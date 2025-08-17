import 'package:than_pkg/than_pkg.dart';

extension IntExtension on int {
  String getSizeLabel({int asFixed = 2}) {
    return toDouble().toFileSizeLabel(asFixed: asFixed);
  }
}
