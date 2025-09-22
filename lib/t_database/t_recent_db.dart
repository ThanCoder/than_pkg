// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:than_pkg/than_pkg.dart';

class TRecentDB {
  final DataIO io;
  final String root;
  TRecentDB({required this.root}) : io = JsonIO.instance {
    _init();
  }

  static TRecentDB? _instance;
  static String _root = '';
  static void init({required String rootPath}) {
    _root = rootPath;
  }

  static TRecentDB get getInstance {
    if (_root.isEmpty) {
      throw PathNotFoundException(
        _root,
        OSError(
          'TRecentDB: rootPath:`$_root` Not Found!.Usage: `TRecentDB.init()`',
        ),
      );
    }
    _instance ??= TRecentDB(root: _root);
    return _instance!;
  }

  // class
  Map<String, dynamic> _map = {};

  void _init() async {
    try {
      if (root.isEmpty) return;
      if (!File(root).existsSync()) return;
      final source = await io.read(root);
      _map = jsonDecode(source);
    } catch (e) {
      debugPrint('[TRecentDB:init]: ${e.toString()}');
    }
  }

  Future<void> save() async {
    try {
      if (root.isEmpty) return;
      await io.write(root, JsonEncoder.withIndent(' ').convert(_map));
    } catch (e) {
      debugPrint('[TRecentDB:save]: ${e.toString()}');
    }
  }

  // set
  Future<void> put<T>(String key, T value) async {
    _map[key] = value;
    await save();
  }

  Future<void> putString(String key, String value) async {
    _map[key] = value;
    await save();
  }

  Future<void> putInt(String key, int value) async {
    _map[key] = value;
    await save();
  }

  Future<void> putDouble(String key, double value) async {
    _map[key] = value;
    await save();
  }

  Future<void> putBool(String key, bool value) async {
    _map[key] = value;
    await save();
  }

  // get
  T get<T>(String key, {required T def}) {
    return _map.get<T>([key], def: def);
  }

  String getString(String key, {String def = ''}) {
    return _map.getString([key], def: def);
  }

  int getInt(String key, {int def = 0}) {
    return _map.getInt([key], def: def);
  }

  double getDouble(String key, {double def = 0.0}) {
    return _map.getDouble([key], def: def);
  }

  bool getBool(String key, {bool def = false}) {
    return _map.getBool([key], def: def);
  }
}
