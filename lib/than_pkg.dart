import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:than_pkg/android_pkg/android_pkg.dart';
import 'package:than_pkg/linux_pkg/linux_pkg.dart';
import 'package:than_pkg/platforms/than_pkg_interface.dart';
import 'package:than_pkg/platforms/than_pkg_android.dart';
import 'package:than_pkg/platforms/than_pkg_linux.dart';
import 'package:than_pkg/types/src_dest_type.dart';
import 'package:than_pkg/utils/app_util.dart';
import 'package:window_manager/window_manager.dart';

export 'extensions/index.dart';
export 'than_pkg_lib.dart';
export 'utils/index.dart';
export 'services/index.dart';
export 't_database/index.dart';
export 'view/index.dart';

class ThanPkg implements ThanPkgInterface {
  //singleton
  static final ThanPkg instance = _createInstance();
  static ThanPkg get platform => instance;
  // factory ThanPkg() => instance;

  static ThanPkg _createInstance() {
    if (Platform.isAndroid) {
      return ThanPkgAndroid();
    } else if (Platform.isLinux) {
      return ThanPkgLinux();
    } else {
      return ThanPkg._();
    }
  }

  ThanPkg(); //private consturctor
  //unname constructor
  ThanPkg._();
  // class //
  //permission
  static AndroidPkg get android => AndroidPkg.android;
  static LinuxPkg get linux => LinuxPkg.linux;
  static AppUtil get appUtil => AppUtil.instance;
  

  Future<void> init({bool isShowDebugLog = false}) async {
    ThanPkg.isShowDebugLog = isShowDebugLog;
    if (Platform.isLinux) {
      await windowManager.ensureInitialized();
    }
  }

  // debug
  static bool isShowDebugLog = false;

  static void showDebugLog(String message, {String? tag}) {
    if (!isShowDebugLog) return;
    if (tag != null) {
      debugPrint('[$tag]: $message');
    } else {
      debugPrint(message);
    }
  }

  /// Generates cover images for a list of PDF files.
  ///
  /// This function processes the given list of PDF file paths and generates
  /// their cover images, saving them to the specified output directory.
  ///
  /// for linux -> `sudo apt install poppler-utils`
  ///
  /// ### Parameters:
  /// - [outDirPath] (required): The directory path where the generated cover images will be saved.
  /// - [pdfPathList] (required): A list of PDF file paths for which covers need to be generated.
  /// - [iconSize] (not working! လောလောဆယ် မရသေးပါ) (optional, default: 300): The size (in pixels) of the generated cover images.
  ///
  /// ### Example Usage:
  /// ```dart
  /// await genPdfCover(
  ///   outDirPath: '/storage/emulated/0/PdfCovers',
  ///   pdfPathList: ['/storage/emulated/0/Download/sample.pdf'],
  ///   iconSize: 400,
  /// );
  /// ```
  ///
  ///outDirPath -> `/storage/emulated/0/PdfCovers/sample.png`
  ///
  /// This function is asynchronous and returns a [Future] that completes when all covers are generated.
  /// **Deprecated:** Use `generatePdfCover` instead.
  @Deprecated('Use genPdfThumbnail ')
  @override
  Future<void> genPdfCover({
    required String outDirPath,
    required List<String> pdfPathList,
    int iconSize = 300,
  }) {
    throw UnimplementedError();
  }

  /// Retrieves the local IP address of the device.
  ///
  /// This function attempts to fetch the local IP address of the device
  /// in a network. The returned IP address may vary based on the network type
  /// (Wi-Fi, Ethernet, or Mobile Data).
  ///
  /// ### Returns:
  /// - A [Future] that resolves to a [String] containing the local IP address.
  /// - Returns `null` if the IP address cannot be determined.
  ///
  /// ### Example Usage:
  /// ```dart
  /// String? ip = await getLocalIpAddress();
  /// print("Local IP Address: $ip");
  /// ```
  ///
  /// This method should be implemented to provide actual functionality.
  @override
  Future<String?> getLocalIpAddress() {
    // TODO: implement getLocalIpAddress
    throw UnimplementedError();
  }

  /// Retrieves the platform version of the device.
  ///
  /// This function returns the operating system version of the device.
  /// It is useful for checking the OS version for conditional logic.
  ///
  /// ### Returns:
  /// - A [Future] that resolves to a [String] containing the platform version.
  /// - Returns `null` if the version cannot be determined.
  ///
  /// ### Example Usage:
  /// ```dart
  /// String? version = await getPlatformVersion();
  /// print("Platform Version: $version");
  /// ```
  ///
  /// This method should be implemented to provide actual functionality.
  @override
  Future<String?> getPlatformVersion() {
    // TODO: Implement getPlatformVersion method.
    throw UnimplementedError();
  }

  /// Opens a given URL in the default web browser or app.
  ///
  /// This function attempts to launch the specified URL using the
  /// system's default browser or an appropriate app (e.g., YouTube app
  /// for a YouTube link).
  ///
  /// ### Parameters:
  /// - [url] (required): The URL to be opened.
  ///
  /// ### Returns:
  /// - A [Future] that resolves to `true` if the URL was successfully opened.
  /// - Returns `false` if the URL could not be opened.
  ///
  /// ### Example Usage:
  /// ```dart
  /// await openUrl(url: 'https://flutter.dev');
  /// ```
  ///
  /// This method should be implemented to provide actual functionality.
  @override
  Future<void> openUrl({required String url}) {
    // TODO: Implement openUrl method.
    throw UnimplementedError();
  }

  /// Toggles full-screen mode on or off.
  ///
  /// This function enables or disables full-screen mode based on the
  /// provided [isFullScreen] value.
  ///
  /// ### Parameters:
  /// - [isFullScreen] (required): A `bool` value indicating whether
  ///   to enter (`true`) or exit (`false`) full-screen mode.
  ///
  /// ### Returns:
  /// - A [Future] that completes when the full-screen state is toggled.
  ///
  /// ### Example Usage:
  /// ```dart
  /// await toggleFullScreen(isFullScreen: true); // Enter full-screen
  /// await toggleFullScreen(isFullScreen: false); // Exit full-screen
  /// ```
  ///
  /// This method should be implemented to provide actual functionality.
  @override
  Future<void> toggleFullScreen({required bool isFullScreen}) {
    // TODO: Implement toggleFullScreen method.
    throw UnimplementedError();
  }

  /// Retrieves the unique device ID.
  ///
  /// This function returns a unique identifier for the device.
  /// The method of obtaining the device ID may vary based on
  /// the platform (Android, Linux, etc.).
  ///
  @override
  Future<String?> getDeviceId() {
    // TODO: Implement getDeviceId method.
    throw UnimplementedError();
  }

  /// Toggles the keep screen awake mode.
  ///
  /// This function prevents the device screen from turning off automatically
  /// based on the provided [isKeep] value.
  ///
  /// ### Parameters:
  /// - [isKeep] (required): A `bool` value indicating whether to keep
  ///   the screen awake (`true`) or allow it to turn off (`false`).
  ///
  /// ### Returns:
  /// - A [Future] that completes when the screen state is toggled.
  ///
  /// ### Example Usage:
  /// ```dart
  /// await toggleKeepScreen(isKeep: true); // Keep screen awake
  /// await toggleKeepScreen(isKeep: false); // Allow screen to turn off
  /// ```
  ///
  /// This method should be implemented to provide actual functionality.
  @override
  Future<void> toggleKeepScreen({required bool isKeep}) {
    // TODO: Implement toggleKeepScreen method.
    throw UnimplementedError();
  }

  /// Checks if the storage permission is granted.
  ///
  /// This function checks the current storage permission status. If the permission
  /// is granted, it returns `true`. If the permission is not granted, it requests
  /// the permission and returns `true` if granted, or `false` if the permission is denied.
  ///
  /// ### Tested Devices
  /// android version 5 -> 15 tested
  ///
  /// ### Returns:
  /// - A [Future<bool>] that completes with `true` if storage permission is granted,
  ///   or `false` if the permission is denied or not granted after a request.
  ///
  /// ### Example Usage:
  /// ```dart
  /// bool isGranted = await isStoragePermissionGranted();
  /// if (isGranted) {
  ///   // Permission granted, proceed with accessing storage
  /// } else {
  ///   // Permission denied, show an error or request again
  /// }
  /// ```
  ///### Android Manifest
  ///```xml
  ///<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE"tools:ignore="ScopedStorage" />
  ///<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
  ///<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
  ///```
  /// This method should be implemented to check and request storage permissions.
  @override
  Future<bool> isStoragePermissionGranted() async {
    // TODO: Implement isStoragePermissionGranted method.
    throw UnimplementedError();
  }

  /// Requests the storage permission.
  ///
  /// This function requests the storage permission from the user. If the permission
  /// is not granted, it triggers the permission request and returns the result.
  ///
  /// ### Tested Devices
  /// android version 5 -> 15 tested
  ///
  /// ### Returns:
  /// - A [Future<void>] that completes when the permission request has been made.
  ///
  /// ### Example Usage:
  /// ```dart
  /// await requestStoragePermission(); // Request storage permission
  /// ```
  ///### Android Manifest
  ///```xml
  ///<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE"tools:ignore="ScopedStorage" />
  ///<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
  ///<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
  ///```
  /// This method should be implemented to handle the permission request logic.
  ///
  @override
  Future<void> requestStoragePermission() async {
    // TODO: Implement requestStoragePermission method.
    throw UnimplementedError();
  }

  /// Retrieves a list of available Wi-Fi IP addresses.
  ///
  /// for linux -> `sudo apt install poppler-utils`
  ///
  /// This function scans and returns a list of IP addresses
  /// associated with available Wi-Fi networks. The returned list
  /// may contain multiple IP addresses if the device is connected
  /// to different interfaces.
  ///
  /// ### Returns:
  /// - A [Future] that resolves to a `List<String>` containing the IP addresses.
  /// - Throws an error if retrieving the Wi-Fi addresses fails.
  ///
  /// ### Example Usage:
  /// ```dart
  /// List<String> wifiIPs = await getWifiAddressList();
  /// print("Available Wi-Fi IPs: $wifiIPs");
  /// ```
  ///### Android Manifest
  ///```xml
  ///<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
  ///<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
  ///```
  /// This method should be implemented to provide actual functionality.
  @override
  Future<List<String>> getWifiAddressList() {
    // TODO: implement getWifiAddressList
    throw UnimplementedError();
  }

  /// Generates cover images (thumbnails) for a list of video files.
  ///
  /// This function processes the given list of video file paths and extracts
  /// their cover images (thumbnails), saving them to the specified output directory.
  ///
  /// for linux -> `sudo apt install ffmpeg`
  ///
  /// ### Parameters:
  /// - [outDirPath] (required): The directory path where the generated thumbnails will be saved.
  /// - [videoPathList] (required): A list of video file paths for which covers need to be generated.
  /// - [iconSize] (optional, default: 300): The size (in pixels) of the generated cover images.
  ///
  /// ### Returns:
  /// - A [Future] that completes when all video covers are generated.
  ///
  /// ### Example Usage:
  /// ```dart
  /// await genVideoCover(
  ///   outDirPath: '/storage/emulated/0/VideoCovers',
  ///   videoPathList: ['/storage/emulated/0/Movies/sample.mp4'],
  ///   iconSize: 400,
  /// );
  /// ```
  ///
  /// This method should be implemented to provide actual functionality.
  /// /// **Deprecated:** Use `genVideoThumbnail` instead.
  @Deprecated('Use genVideoThumbnail ')
  @override
  Future<void> genVideoCover({
    required String outDirPath,
    required List<String> videoPathList,
    int iconSize = 300,
  }) {
    // TODO: implement getVideoCover
    throw UnimplementedError();
  }

  /// Returns the root directory path of the app.
  ///
  /// This method retrieves the root directory where the app has access
  /// to store or retrieve files.
  ///
  /// **Platform-specific behavior:**
  /// - On Android `storage/emulated/0/Android/data/com.example.myapp/files`
  /// - On Linux `Directory.current.path`
  ///
  /// Returns:
  /// - A `Future<String?>` resolving to the root path of the app.
  /// - Throws an `UnimplementedError` if the method is not implemented.
  ///
  /// Example:
  /// ```dart
  /// String? path = await getAppRootPath();
  /// if (path != null) {
  ///   print("App root path: $path");
  /// }
  /// ```
  @override
  Future<String?> getAppRootPath() {
    // TODO: implement getAppRootPath
    throw UnimplementedError();
  }

  /// Returns the external storage path of the app.
  ///
  /// This method retrieves the app's external storage directory,
  /// which is useful for saving files that should be accessible
  /// outside the app's internal storage.
  ///
  /// **Platform-specific behavior:**
  ///
  /// - On Android, /storage/emulated/0.
  /// - On Linux `/home/[your pc name]`
  /// - On iOS, external storage is not available in the same way.
  /// ```
  @override
  Future<String?> getAppExternalPath() {
    // TODO: implement getAppExternalPath
    throw UnimplementedError();
  }

  @override
  Future<bool> isAppSystemThemeDarkMode() {
    // TODO: implement isAppSystemThemeDarkMode
    throw UnimplementedError();
  }

  @override
  Future<String?> getWifiSSID() {
    // TODO: implement getWifiSSID
    throw UnimplementedError();
  }

  @override
  Future<int?> getAppBatteryLevel() {
    // TODO: implement getAppBatteryLevel
    throw UnimplementedError();
  }

  @override
  Future<PackageInfo> getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  @override
  Future<void> launch(String source) {
    // TODO: implement launch
    throw UnimplementedError();
  }

  @override
  Future<void> genPdfThumbnail({
    required List<SrcDestType> pathList,
    int iconSize = 300,
    bool isOverride = false,
  }) {
    // TODO: implement genPdfCover2
    throw UnimplementedError();
  }

  @override
  Future<void> genVideoThumbnail({
    required List<SrcDestType> pathList,
    int iconSize = 300,
    bool isOverride = false,
  }) {
    // TODO: implement genVideoCover2
    throw UnimplementedError();
  }

  @override
  Future<bool> isInternetConnected() {
    // TODO: implement isInternetConnected
    throw UnimplementedError();
  }
  
  @override
  Future<void> showNotification({required String title, int? notificationId, String content = 'content'}) {
    // TODO: implement showNotification
    throw UnimplementedError();
  }
}
