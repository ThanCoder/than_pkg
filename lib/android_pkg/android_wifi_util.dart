import 'package:flutter/services.dart';

class AndroidWifiUtil {
  static final AndroidWifiUtil wifi = AndroidWifiUtil._();
  AndroidWifiUtil._();
  factory AndroidWifiUtil() => wifi;

  final _channel = const MethodChannel('than_pkg');
  final _name = 'wifiUtil';

  Future<String> getWifiSSID() async {
    return await _channel.invokeMethod<String>('$_name/getWifiSSID') ?? '';
  }

  Future<String> getLocalIpAddress() async {
    return await _channel.invokeMethod<String>('$_name/getLocalIpAddress') ??
        '';
  }

  ///### Android Manifest
  ///```xml
  ///<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
  ///<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
  ///```
  Future<String> getWifiAddress() async {
    return await _channel.invokeMethod<String>('$_name/getWifiAddress') ?? '';
  }

  ///### Android Manifest
  ///```xml
  ///<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
  ///<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
  ///```
  Future<List<String>> getWifiAddressList() async {
    final res =
        await _channel.invokeMethod<List>('$_name/getWifiAddressList') ?? [];
    return List<String>.from(res);
  }
}
