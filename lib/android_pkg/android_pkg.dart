import 'package:than_pkg/android_pkg/android_media_util.dart';
import 'package:than_pkg/android_pkg/android_webview_util.dart';
import 'package:than_pkg/android_pkg/index.dart';

import 'android_noti_util.dart';

class AndroidPkg {
  static final AndroidPkg android = AndroidPkg._();
  AndroidPkg._();
  factory AndroidPkg() => android;

  AndroidAppUtil get app => AndroidAppUtil.app;
  AndroidCamera get camera => AndroidCamera.camera;
  AndroidPermission get permission => AndroidPermission.permission;
  AndroidThumbnail get thumbnail => AndroidThumbnail.thumbnail;
  AndroidWifiUtil get wifi => AndroidWifiUtil.wifi;
  AndroidNotiUtil get notiUtil => AndroidNotiUtil.instance;
  AndroidWebviewUtil get webview => AndroidWebviewUtil.instance;
  AndroidMediaUtil get media => AndroidMediaUtil.instance;
  AndroidIntentUtil get intent => AndroidIntentUtil.instance;
}
