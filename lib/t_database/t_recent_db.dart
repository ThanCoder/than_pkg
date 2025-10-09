// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:than_pkg/than_pkg.dart';

class TRecentDB {
  final DataIO io;
  String _root = '';
  TRecentDB() : io = JsonIO.instance;

  static TRecentDB? _instance;

  static TRecentDB get getInstance {
    _instance ??= TRecentDB();
    return _instance!;
  }

  void setRootPath(String root) {
    _root = root;
  }

  String get getRoot => _root;

  // class
  Map<String, dynamic> _map = {};

  Future<void> init({required String rootPath}) async {
    try {
      _root = rootPath;
      if (_root.isEmpty) {
        throw PathNotFoundException(
          _root,
          OSError(
            'TRecentDB: rootPath:`$_root` Not Found!.Usage: `await TRecentDB.getInstance.init(rootPath: \'test.json\')`',
          ),
        );
      }
      if (!File(_root).existsSync()) return;
      final source = await io.read(_root);
      _map = jsonDecode(source);
    } catch (e) {
      debugPrint('[TRecentDB:init]: ${e.toString()}');
    }
  }

  Future<void> save() async {
    try {
      if (_root.isEmpty) return;
      await io.write(_root, JsonEncoder.withIndent(' ').convert(_map));
    } catch (e) {
      debugPrint('[TRecentDB:save]: ${e.toString()}');
    }
  }

  // delete
  Future<void> delete(String key) async {
    _map.remove(key);
    await save();
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
