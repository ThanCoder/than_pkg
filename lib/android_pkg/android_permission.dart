import 'dart:io';

import 'package:flutter/services.dart';
import 'package:than_pkg/android_pkg/android_noti_util.dart';

class AndroidPermission {
  static final AndroidPermission permission = AndroidPermission._();
  AndroidPermission._();
  factory AndroidPermission() => permission;

  final _channel = const MethodChannel('than_pkg');
  final _name = 'permissionUtil';

  ///```xml
  ///
  ///<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
  ///```
  Future<bool> checkAndRequestNotificationPermission() async {
    return await AndroidNotiUtil.instance
        .checkAndRequestNotificationPermission();
  }

  ///```xml
  ///
  ///<uses-permission android:name="android.permission.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS" />
  ///```
  Future<void> requestBatteryOptimizationPermission() async {
    await _channel.invokeMethod('$_name/requestBatteryOptimizationPermission');
  }

  ///```xml
  ///
  ///<uses-permission android:name="android.permission.REQUEST_INSTALL_PACKAGES"/>
  ///```
  Future<void> checkCanRequestPackageInstallsPermission() async {
    await _channel.invokeMethod(
      '$_name/checkCanRequestPackageInstallsPermission',
    );
  }

  ///### Android Manifest
  ///
  ///```xml
  ///<uses-permission android:name="android.permission.QUERY_ALL_PACKAGES" tools:ignore="QueryAllPackagesPermission" />
  ///```
  Future<bool> isPackageInstallPermission() async {
    return await _channel.invokeMethod<bool>(
          '$_name/isPackageInstallPermission',
        ) ??
        false;
  }

  Future<bool> isStoragePermissionGranted() async {
    if (!Platform.isAndroid) return true;
    return await _channel.invokeMethod<bool>(
          '$_name/isStoragePermissionGranted',
        ) ??
        false;
  }

  Future<bool> isCameraPermission() async {
    return await _channel.invokeMethod<bool>('$_name/isCameraPermission') ??
        false;
  }

  Future<bool> isLocationPermission() async {
    return await _channel.invokeMethod<bool>('$_name/isLocationPermission') ??
        false;
  }

  ///### Android Manifest
  ///```xml
  ///
  ///<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE"tools:ignore="ScopedStorage" />
  ///<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
  ///<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
  ///
  ///```
  Future<void> requestStoragePermission() async {
    if (!Platform.isAndroid) return;
    await _channel.invokeMethod('$_name/requestStoragePermission');
  }

  ///### Android Manifest
  ///
  ///```xml
  ///
  ///<uses-permission android:name="android.permission.QUERY_ALL_PACKAGES" tools:ignore="QueryAllPackagesPermission" />
  ///```
  ///
  Future<void> requestPackageInstallPermission() async {
    await _channel.invokeMethod('$_name/requestPackageInstallPermission');
  }

  ///
  ///```xml
  ///
  ///<uses-permission android:name="android.permission.CAMERA" />
  ///```
  ///
  Future<void> requestCameraPermission() async {
    await _channel.invokeMethod('$_name/requestCameraPermission');
  }

  ///```xml
  ///
  ///<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
  ///<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
  ///<!-- Android 10+ background location access (optional) -->
  ///<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
  ///```
  Future<void> requestLocationPermission() async {
    await _channel.invokeMethod('$_name/requestLocationPermission');
  }
}
