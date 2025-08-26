// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'data_io.dart';
import 't_database_listener.dart';

abstract class TJsonDatabase<T> {
  final DataIO io;
  final String path;
  TJsonDatabase({required this.path}) : io = JsonIO.instance;

  T fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(T value);
  // ကြိုပေးထား

  Future<List<T>> getAll() async {
    final json = await io.read(path);
    if (json.isEmpty) return [];
    List<dynamic> jsonList = jsonDecode(json);
    return jsonList.map((e) => fromMap(e)).toList();
  }

  Future<void> add(T value) async {
    final list = await getAll();
    list.add(value);
    await save(list);
  }

  Future<void> update(int index, T value) async {
    final list = await getAll();
    list[index] = value;
    await save(list);
  }

  Future<void> delete(int index) async {
    final list = await getAll();
    list.removeAt(index);
    await save(list);
  }

  Future<void> save(List<T> list, {bool isPretty = true}) async {
    final jsonList = list.map((e) => toMap(e)).toList();
    await io.write(path, JsonEncoder.withIndent(' ').convert(jsonList));
    notify();
  }

  // listener
  final List<TDatabaseListener> _listeners = [];

  // register/unregister methods
  void addListener(TDatabaseListener listener) {
    _listeners.add(listener);
  }

  void removeListener(TDatabaseListener listener) {
    _listeners.remove(listener);
  }

  void notify() {
    for (final listener in _listeners) {
      listener.onDatabaseChanged();
    }
  }
}
