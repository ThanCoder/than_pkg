import 'dart:async';

import 'package:flutter/services.dart';

class AndroidNotiUtil {
  static final AndroidNotiUtil instance = AndroidNotiUtil._();
  AndroidNotiUtil._();
  factory AndroidNotiUtil() => instance;

  final _channel = const MethodChannel('than_pkg');
  final _name = 'notiUtil';

  ///```xml
  ///<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
  ///```
  ///Notification Click Listener
  // Stream<int> notificationClickedListener() {
  //   final controller = StreamController<int>();
  //   _channel.setMethodCallHandler((call) async {
  //     if (call.method == 'notificationClick') {
  //       final id = call.arguments ?? -1;
  //       controller.add(id);
  //     }
  //   });
  //   return controller.stream;
  // }

  ///```xml
  ///<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
  ///```
  Future<bool> checkAndRequestNotificationPermission() async {
    final completer = Completer<bool>();
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'notiPermissionResult') {
        final isGranted = call.arguments['isGranted'] ?? false;
        completer.complete(isGranted);
      } else {
        completer.complete(false);
      }
    });
    // send android
    _channel.invokeMethod<bool>('$_name/askNotificationPermission').then((
      isGranted,
    ) {
      if (isGranted == null) return;
      completer.complete(isGranted);
    });

    return completer.future;
  }

  Future<void> showNotification({
    int notificationId = 1,
    String channelId = 'channel_id',
    String channelName = 'channel_name',
    String channelDesc = '',
    String title = 'Noti Content Title',
    String content = 'Noti Content Text',
    bool isAutoReqPermission = true,
  }) async {
    if (isAutoReqPermission) {
      await checkAndRequestNotificationPermission();
    }

    await _channel.invokeMethod('$_name/showNotification', {
      'notificationId': notificationId,
      'channelId': channelId,
      'channelName': channelName,
      'channelDesc': channelDesc,
      'title': title,
      'content': content,
    });
  }

  Future<void> showCompleteNotification({
    int notificationId = 1,
    String channelId = 'channel_id',
    String title = 'Completed',
    String content = 'Done',
  }) async {
    await _channel.invokeMethod('$_name/showCompleteNotification', {
      'notificationId': notificationId,
      'channelId': channelId,
      'title': title,
      'content': content,
    });
  }

  Future<void> showProgressNotification({
    required int progress, // 0 ~ 100
    int notificationId = 1,
    String channelId = 'channel_id',
    String channelName = 'channel_name',
    String channelDesc = '',
    String title = 'Noti Content Title',
    String content = 'Noti Content Text',
    bool indeterminate = false,
  }) async {
    await _channel.invokeMethod('$_name/showProgressNotification', {
      'notificationId': notificationId,
      'channelId': channelId,
      'channelName': channelName,
      'channelDesc': channelDesc,
      'title': title,
      'content': content,
      "progress": progress,
      "indeterminate": indeterminate,
    });
  }
}
