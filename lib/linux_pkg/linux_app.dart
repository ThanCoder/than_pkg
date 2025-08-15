import 'dart:io';

import 'package:than_pkg/than_pkg.dart';

class LinuxApp {
  static final LinuxApp app = LinuxApp._();
  LinuxApp._();
  factory LinuxApp() => app;

  Future<void> launch(String source) async {
    await Process.run('xdg-open', [source]);
  }

  Future<bool> isInternetConnected() async {
    //ping -c 4 google.com
    try {
      final res = await Process.run('ping', ['-c', '4', 'google.com']);
      if (res.stderr.toString().isNotEmpty) {
        return false;
      }
      if (res.stdout.toString().isNotEmpty) {
        return true;
      }

      // print('succ: ${res.stdout}');
      // print('error: ${res.stderr}');
    } catch (e) {
      ThanPkg.showDebugLog(e.toString(), tag: 'LinuxApp:isInternetConnected');
    }

    return false;
  }

  Future<int?> getAppBatteryLevel() async {
    try {
      final result = await Process.run('cat', [
        '/sys/class/power_supply/BAT0/capacity',
      ]);
      final res = result.stdout.toString().trim();
      if (int.tryParse(res) != null) {
        return int.parse(res);
      }
    } catch (e) {
      ThanPkg.showDebugLog(e.toString(), tag: 'LinuxApp:getAppBatteryLevel');
    }
    return null;
  }

  Future<String> getDeviceId() async {
    try {
      final id = await File('/etc/machine-id').readAsString();
      return id.trim();
    } catch (_) {
      // fallback
      final id2 = await File('/var/lib/dbus/machine-id').readAsString();
      return id2.trim();
    }
  }
}
