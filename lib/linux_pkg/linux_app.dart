import 'dart:io';

import 'package:flutter/material.dart';
import 'package:than_pkg/than_pkg.dart';

class LinuxApp {
  static final LinuxApp app = LinuxApp._();
  LinuxApp._();
  factory LinuxApp() => app;
  ///```bash
  ///
  ///sudo apt install cheese
  ///
  ///```
  Future<void> openWebCam() async {
    Process.run("cheese", []);
  }

  ///
  ///```bash
  ///
  ///sudo apt install scrot   # Ubuntu/Debian
  ///
  ///sudo dnf install scrot   # Fedora
  ///
  ///sudo pacman -S scrot     # Arch
  ///```
  ///
  Future<void> screenShoot({
    bool isOverride = true,
    String? savedPath,
    int? delaySec,
    bool selectWindow = true,
    bool includeWindowBorder = false,
    bool includeMousePointer = false,
  }) async {
    try {
      List<String> list = [];
      if (isOverride) {
        list.add('-o');
      }
      if (delaySec != null) {
        list.add('-d');
        list.add(delaySec.toString());
      }
      if (selectWindow) {
        list.add('-s');
      }
      if (includeWindowBorder) {
        list.add('-b');
      }
      if (includeMousePointer) {
        list.add('-m');
      }

      if (savedPath != null && savedPath.isNotEmpty) {
        list.add(savedPath);
      }
      await Process.run('scrot', list);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

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
