import 'dart:io';

extension StringExtension on String {
  String toCaptalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1, length)}';
  }

  String getName({bool withExt = true}) {
    final name = split(Platform.pathSeparator).last;
    if (!withExt) {
      return name.split('.').first;
    }
    return name;
  }

  String get getExt {
    return split(Platform.pathSeparator).last;
  }

  String pathJoin(String path, String name) {
    return '$path${Platform.pathSeparator}$name';
  }
}
