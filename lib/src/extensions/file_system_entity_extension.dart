import 'dart:io';

import 'package:than_pkg/src/extensions/datetime_extension.dart';
import 'package:than_pkg/src/extensions/double_extension.dart';

@Deprecated(
  'Use `dart_core_extensions` instead.This extension will be removed in version V6.0.0',
)
extension FileSystemEntityExtension on FileSystemEntity {
  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
  String getName({bool withExt = true}) {
    final name = path.split(Platform.pathSeparator).last;
    if (!withExt) {
      return name.split('.').first;
    }
    return name;
  }

  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
  String get getExt {
    return path.split(Platform.pathSeparator).last;
  }

  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
  bool get isDirectory {
    return statSync().type == FileSystemEntityType.directory;
  }

  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
  bool get isFile {
    return statSync().type == FileSystemEntityType.file;
  }

  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
  int get getSize {
    return statSync().size;
  }

  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
  String toParseTime({String pattern = 'hh:mm a dd/MM/yyyy'}) {
    return statSync().modified.toParseTime(pattern: pattern);
  }

  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
  DateTime get getDate {
    return statSync().modified;
  }

  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
  String getSizeLabel({int asFixed = 2}) {
    return statSync().size.toDouble().toFileSizeLabel(asFixed: asFixed);
  }

  @Deprecated(
    'Use `dart_core_extensions` instead.This method will be removed in version V6.0.0',
  )
  String toFileSizeLabel({int asFixed = 2}) {
    return statSync().size.toDouble().toFileSizeLabel(asFixed: asFixed);
  }
}
