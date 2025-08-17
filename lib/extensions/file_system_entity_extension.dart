import 'dart:io';

import 'package:than_pkg/extensions/double_extension.dart';


extension FileSystemEntityExtension on FileSystemEntity {
  String getName({bool withExt = true}) {
    final name = path.split('/').last;
    if (!withExt) {
      return name.split('.').first;
    }
    return name;
  }

  String get getExt {
    return path.split('/').last;
  }

  bool get isDirectory {
    return statSync().type == FileSystemEntityType.directory;
  }

  bool get isFile {
    return statSync().type == FileSystemEntityType.file;
  }

  String getSizeLabel({int asFixed = 2}) {
    return statSync().size.toDouble().toFileSizeLabel(asFixed: asFixed);
  }
}

