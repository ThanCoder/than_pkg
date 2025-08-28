import 'dart:io';

import 'package:flutter/foundation.dart';

class LinuxWifiUtil {
  static final LinuxWifiUtil wifi = LinuxWifiUtil._();
  LinuxWifiUtil._();
  factory LinuxWifiUtil() => wifi;

  Future<List<String>> getWifiAddressList() async {
    List<String> list = [];
    try {
      // ifconfig && ip neigh
      // scan ifconfig
      ProcessResult ifconfig = await Process.run('ifconfig', ['wlp2s0']);
      // host finder
      RegExp ipRegex = RegExp(r'(\d+\.\d+\.\d+\.\d+)');

      if (ifconfig.exitCode == 0) {
        final res = ipRegex.allMatches(ifconfig.stdout.toString()).map((e) {
          return e.group(0);
        }).toList();
        list.addAll(res.cast<String>());
      }
      // scan ip neigh
      ProcessResult ipRes = await Process.run('ip', ['neigh']);
      final res = ipRegex.allMatches(ipRes.stdout.toString()).map((e) {
        return e.group(0);
      }).toList();
      for (var ip in res) {
        if (ip != null && ip.isNotEmpty) {
          list.add(ip);
        }
      }
    } catch (e) {
      debugPrint("getWifiAddressList: ${e.toString()}");
    }
    return list;
  }
}
