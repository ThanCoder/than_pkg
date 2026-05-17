import 'dart:io';

@Deprecated(
  'Use `dart_core_extensions` instead.This extension will be removed in version V6.0.0',
)
extension StringExtension on String {
  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
  String toCaptalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1, length)}';
  }

  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
  String getName({bool withExt = true}) {
    final name = split(Platform.pathSeparator).last;
    if (!withExt) {
      return name.split('.').first;
    }
    return name;
  }

  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
  String get getExt {
    return split(Platform.pathSeparator).last;
  }

  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
  String pathJoin(String path, String name) {
    return '$path${Platform.pathSeparator}$name';
  }
}
