import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:than_pkg/than_pkg.dart';

class InstalledApp {
  String appName;
  String packageName;
  String versionName;
  String versionCode;
  Uint8List? coverData;
  int? size;

  InstalledApp({
    required this.appName,
    required this.packageName,
    required this.versionName,
    required this.versionCode,
    this.coverData,
    this.size,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appName': appName,
      'packageName': packageName,
      'versionName': versionName,
      'versionCode': versionCode,
    };
  }

  factory InstalledApp.fromMap(Map<String, dynamic> map) {
    String iconBase64 = map.getString(['iconBase64']);
    Uint8List? coverData;
    if (iconBase64.isNotEmpty) {
      coverData = base64Decode(iconBase64);
    }
    return InstalledApp(
      appName: map.getString(['appName']),
      packageName: map.getString(['packageName']),
      versionName: map.getString(['versionName']),
      versionCode: map.getString(['versionCode']),
      coverData: coverData,
      size: map.getInt(['size']),
    );
  }

  Future<void> export(String savedPath) async {
    await ThanPkg.android.app.exportApk(
      packageName: packageName,
      savedPath: savedPath,
    );
  }

  // Future<Uint8List?> getCoverData() async {
  //   _cacheCoverData ??= await ThanPkg.android.app.getAppIcon(
  //     packageName: packageName,
  //   );
  //   return _cacheCoverData;
  // }

  // Future<int?> getAppSize() async {
  //   _cacheApkSize ??= await ThanPkg.android.app.getApkSize(
  //     packageName: packageName,
  //   );
  //   return _cacheApkSize;
  // }

  @override
  String toString() {
    return '\nname: $appName - packageName:$packageName';
  }
}
