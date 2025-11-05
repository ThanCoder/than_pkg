import 'dart:io';

import 'package:than_pkg/than_pkg.dart';

extension FileExtension on File {
  String getName({bool withExt = true}) {
    final name = path.split(Platform.pathSeparator).last;
    if (!withExt) {
      return name.split('.').first;
    }
    return name;
  }

  String get getExt {
    return path.split(Platform.pathSeparator).last;
  }

  bool get isDirectory {
    return statSync().type == FileSystemEntityType.directory;
  }

  bool get isFile {
    return statSync().type == FileSystemEntityType.file;
  }

  int get getSize {
    return statSync().size;
  }

  String toParseTime({String pattern = 'hh:mm a dd/MM/yyyy'}) {
    return statSync().modified.toParseTime(pattern: pattern);
  }

  DateTime get getDate {
    return statSync().modified;
  }

  String getSizeLabel({int asFixed = 2}) {
    return statSync().size.toDouble().toFileSizeLabel(asFixed: asFixed);
  }
  String toFileSizeLabel({int asFixed = 2}) {
    return statSync().size.toDouble().toFileSizeLabel(asFixed: asFixed);
  }
}
