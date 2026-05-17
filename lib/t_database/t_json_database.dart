// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:than_pkg/t_database/t_database.dart';

import 'data_io.dart';

abstract class TJsonDatabase<T> extends TDatabase<T> {
  final DataIO io;
  TJsonDatabase({required super.root}) : io = JsonIO.instance;

  T fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(T value);
  String getId(T value);

  @override
  Future<void> update(String id, T value) async {
    final list = await getAll();
    final index = list.indexWhere((e) => getId(e) == id);
    if (index == -1) throw Exception('id: $id Not Found!');
    list[index] = value;
    notify(TDatabaseListenerTypes.update, id);
    await save(list);
  }

  @override
  Future<void> delete(String id) async {
    final list = await getAll();
    final index = list.indexWhere((e) => getId(e) == id);
    if (index == -1) throw Exception('id: $id Not Found!');
    list.removeAt(index);
    notify(TDatabaseListenerTypes.delete, id);
    await save(list);
  }

  @override
  Future<List<T>> getAll({Map<String, dynamic>? query = const {}}) async {
    final json = await io.read(root);
    if (json.isEmpty) return [];
    List<dynamic> jsonList = jsonDecode(json);
    return jsonList.map((e) => fromMap(e)).toList();
  }

  @override
  Future<void> add(T value) async {
    final list = await getAll();
    list.add(value);
    notify(TDatabaseListenerTypes.add, getId(value));
    await save(list);
  }

  Future<void> save(List<T> list, {bool isPretty = true}) async {
    final jsonList = list.map((e) => toMap(e)).toList();
    if (isPretty) {
      await io.write(root, JsonEncoder.withIndent(' ').convert(jsonList));
    } else {
      await io.write(root, jsonEncode(jsonList));
    }
    notify(TDatabaseListenerTypes.saved, null);
  }
}
