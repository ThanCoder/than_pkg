import 'dart:io';

class FPath {
  static String join(String path, String name) {
    return '$path${Platform.pathSeparator}$name';
  }
}
