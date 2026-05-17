import 'dart:io';

import 'package:flutter/foundation.dart';

enum NotiUrgency { low, normal, critical }

class LinuxNotiUtil {
  static final LinuxNotiUtil instance = LinuxNotiUtil._();
  LinuxNotiUtil._();
  factory LinuxNotiUtil() => instance;

  void showNotification({
    required String title,
    String content = 'content',
    String? icon,
    String? appName,
    int? notificationId,
    Duration timeout = const Duration(milliseconds: 2000),
    NotiUrgency level = NotiUrgency.normal,
  }) {
    try {
      final list = [
        "--urgency", level.name, // urgency: low, normal, critical
        "--expire-time", timeout.inMilliseconds.toString(), // timeout in ms
      ];
      if (icon != null) {
        list.add('--icon');
        list.add(icon);
      }
      if (notificationId != null) {
        list.add('--replace-id');
        list.add(notificationId.toString());
      }

      if (appName != null) {
        list.add('--app-name');
        list.add(appName);
      }
      list.add(title);
      list.add(content);

      Process.run('notify-send', list);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
