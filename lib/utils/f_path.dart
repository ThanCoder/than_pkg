import 'dart:io';

String pathJoin(String path, String name) {
  return '$path${Platform.pathSeparator}$name';
}
