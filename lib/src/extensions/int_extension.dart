import 'package:than_pkg/src/extensions/double_extension.dart';

@Deprecated(
  'Use `dart_core_extensions` instead.This extension will be removed in version V6.0.0',
)
extension IntExtension on int {
  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
  String getSizeLabel({int asFixed = 2}) {
    return toDouble().toFileSizeLabel(asFixed: asFixed);
  }

  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
  String toFileSizeLabel({int asFixed = 2}) {
    return toDouble().toFileSizeLabel(asFixed: asFixed);
  }
}
