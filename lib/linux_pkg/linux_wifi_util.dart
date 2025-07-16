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
      ProcessResult result = await Process.run('ifconfig', []);
      RegExp ipRegex = RegExp(r'(192\.168\.\d+\.\d+)');
      if (result.exitCode == 0) {
        final res = ipRegex.allMatches(result.stdout.toString()).map((e) {
          return e.group(0);
        }).toList();
        list = res.cast<String>();
      }
      // scan ip neigh
      ProcessResult ipRes = await Process.run('ip', ['neigh']);
      final res = ipRegex.allMatches(ipRes.stdout.toString()).map((e) {
          return e.group(0);
        }).toList();
      for (var ip in res) {
        if(ip != null && ip.isNotEmpty){
          list.insert(0, ip);
        }
      }
    } catch (e) {
      debugPrint("getWifiAddressList: ${e.toString()}");
    }
    return list;
  }
}
