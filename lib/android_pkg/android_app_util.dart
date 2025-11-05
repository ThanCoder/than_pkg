import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mime/mime.dart';
import 'package:than_pkg/enums/screen_orientation_types.dart';
import 'package:than_pkg/types/android_device_info.dart';
import 'package:than_pkg/types/index.dart';

class AndroidAppUtil {
  static final AndroidAppUtil app = AndroidAppUtil._();
  AndroidAppUtil._();
  factory AndroidAppUtil() => app;

  final _channel = const MethodChannel('than_pkg');
  final _name = 'appUtil';

  /// ## Supported ABIs
  ///```
  ///armeabi-v7a → 32-bit ARM
  ///arm64-v8a → 64-bit ARM
  ///x86 → Intel 32-bit
  ///x86_64 → Intel 64-bit
  ///```
  ///
  ///Kotlin -> `Build.SUPPORTED_ABIS.toList()`
  ///
  Future<List<String>> getABI() async {
    final res = await _channel.invokeMethod<List>('$_name/getABI');
    if (res == null) return [];
    return List<String>.from(res);
  }

  ///
  /// setWallpaper (with imagePath)
  ///
  Future<void> setWallpaper({required String path}) async {
    await _channel.invokeMethod('$_name/setWallpaper', {'path': path});
  }

  ///
  /// Installed apps list (with apkPath)
  ///
  Future<List<InstalledApp>> getInstalledAppsList() async {
    final res =
        await _channel.invokeMethod<List>('$_name/getInstalledApps') ?? [];
    return res
        .map((map) => InstalledApp.fromMap(Map<String, dynamic>.from(map)))
        .toList();
  }

  ///
  /// AppIcon one APK by packageName
  ///
  Future<Uint8List?> getAppIcon({required String packageName}) async {
    final base64Icon = await _channel.invokeMethod<String>(
      "$_name/getAppIcon",
      {"packageName": packageName},
    );
    if (base64Icon == null) return null;
    final bytes = base64Decode(base64Icon);
    return bytes;
  }

  ///
  /// AppIcon one APK by packageName
  ///
  Future<int?> getApkSize({required String packageName}) async {
    final size = await _channel.invokeMethod<int>("$_name/getApkSize", {
      "packageName": packageName,
    });
    if (size == null) return null;
    return size;
  }

  ///
  /// Export one APK by package name
  ///
  Future<void> exportApk({
    required String packageName,
    required String savedPath,
  }) async {
    await _channel.invokeMethod('$_name/exportApk', {
      "packageName": packageName,
      "savedPath": savedPath,
    });
  }

  ///
  /// auto choose file and url
  ///
  /// is supported url,pdf,video
  ///
  Future<void> launch(String source) async {
    if (source.isEmpty) throw Exception('`source` is empty');
    if (source.startsWith('http')) {
      // url
      await launchUrl(source);
    } else {
      //file
      await launchFile(source);
    }
  }

  Future<void> launchFile(String source) async {
    if (!File(source).existsSync()) throw Exception('`source` is exists');
    final mime = lookupMimeType(source) ?? '';
    if (mime.startsWith('video')) {
      await openVideoWithIntent(path: source);
      return;
    }
    if (mime.startsWith('application/pdf')) {
      await openPdfWithIntent(path: source);
      return;
    }
    throw Exception('mime:`$mime` not supported');
  }

  Future<void> launchUrl(String url) async {
    await _channel.invokeMethod('$_name/openUrl', {'url': url});
  }

  Future<int> getSdkInt() async {
    return await _channel.invokeMethod<int>('$_name/getSdkInt') ?? 0;
  }

  Future<AndroidDeviceInfo> getDeviceInfo() async {
    final res = await _channel.invokeMethod<Map>('$_name/getDeviceInfo') ?? {};
    final map = Map<String, dynamic>.from(res);
    return AndroidDeviceInfo.fromMap(map);
  }

  Future<void> openPdfWithIntent({required String path}) async {
    await _channel.invokeMethod('$_name/openPdfWithIntent', {'path': path});
  }

  Future<void> openVideoWithIntent({required String path}) async {
    await _channel.invokeMethod('$_name/openVideoWithIntent', {'path': path});
  }

  Future<void> installApk({required String path}) async {
    await _channel.invokeMethod('$_name/installApk', {'path': path});
  }

  Future<void> openUrl({required String url}) async {
    await _channel.invokeMethod('$_name/openUrl', {'url': url});
  }

  Future<void> showToast(String message) async {
    await _channel.invokeMethod('$_name/showToast', {'message': message});
  }

  Future<void> hideFullScreen() async {
    await _channel.invokeMethod('$_name/hideFullScreen');
  }

  Future<void> showFullScreen() async {
    await _channel.invokeMethod('$_name/showFullScreen');
  }

  Future<bool> isFullScreen() async {
    return await _channel.invokeMethod<bool>('$_name/isFullScreen') ?? false;
  }

  Future<int> getBatteryLevel() async {
    return await _channel.invokeMethod<int>('$_name/getBatteryLevel') ?? 0;
  }

  Future<bool> isInternetConnected() async {
    return await _channel.invokeMethod<bool>('$_name/isInternetConnected') ??
        false;
  }

  Future<bool> isDarkModeEnabled() async {
    return await _channel.invokeMethod<bool>('$_name/isDarkModeEnabled') ??
        false;
  }

  ///
  ///context.filesDir ⇒ /data/data/[your.package.name]/files/
  ///
  Future<String> getFilesDir() async {
    return await _channel.invokeMethod<String>('$_name/getFilesDir') ?? '';
  }

  ///
  ///`storage/emulated/0/Android/data/[com.example.myapp]/files`
  ///
  /// kotlin -> `context.getExternalFilesDir`
  ///
  ///External storage, app-only	No (Android 4.4+ onwards)
  ///
  Future<String> getExternalFilesDir() async {
    return await _channel.invokeMethod<String>('$_name/getExternalFilesDir') ??
        '';
  }

  ///
  ///`storage/emulated/0/Android/data/[your.package.name]/cache`
  ///
  ///kotlin -> `context.externalCacheDir?.path`
  ///
  Future<String> getExternalCachePath() async {
    return await _channel.invokeMethod<String>('$_name/getExternalCachePath') ??
        '';
  }

  ///
  ///`/data/data/<your.package.name>/cache`
  ///
  ///kotlin -> `context.cacheDir.absolutePath`
  ///
  Future<String?> getAppCachePath() async {
    return await _channel.invokeMethod<String>('$_name/getAppCachePath');
  }

  /// It Will Clean!.
  ///
  ///`/data/data/<your.package.name>/cache`
  ///
  ///kotlin -> `context.cacheDir.deleteRecursively()`
  ///
  Future<bool> cleanAppCache() async {
    return await _channel.invokeMethod<bool>('$_name/cleanAppCache') ?? false;
  }

  ///
  /// return `storage/emulated/0`
  ///
  String getAppExternalPath() {
    // return await _channel.invokeMethod<String>('$_name/getAppExternalPath') ??
    //     '';
    return '/storage/emulated/0';
  }

  Future<void> requestOrientation({
    required ScreenOrientationTypes type,
  }) async {
    await _channel.invokeMethod('$_name/requestOrientation', {
      'type': type.name,
    });
  }

  Future<ScreenOrientationTypes?> checkOrientation() async {
    final res = await _channel.invokeMethod<String>('$_name/checkOrientation');
    if (res == null) return null;
    return ScreenOrientationTypes.getType(res);
  }

  Future<ScreenOrientationTypes?> getOrientation() async {
    final res = await _channel.invokeMethod<String>('$_name/checkOrientation');
    if (res == null) return null;
    return ScreenOrientationTypes.getType(res);
  }

  Future<String> getPlatformVersion() async {
    return await _channel.invokeMethod<String>('$_name/getPlatformVersion') ??
        '';
  }

  Future<void> toggleKeepScreenOn({required bool isKeep}) async {
    await _channel.invokeMethod('$_name/toggleKeepScreenOn', {
      'is_keep': isKeep,
    });
  }

  ///
  ///`Settings.Secure.ANDROID_ID`
  ///
  Future<String> getDeviceId() async {
    return await _channel.invokeMethod<String>('$_name/getDeviceId') ?? '';
  }
}
