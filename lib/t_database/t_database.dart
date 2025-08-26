// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:than_pkg/t_database/data_io.dart';
import 'package:than_pkg/t_database/t_converter.dart';

import 't_database_listener.dart';

abstract class TDatabase<T> {
  final DataIO io;
  final TConverter converter;
  final String databasePath;
  TDatabase({
    required this.io,
    required this.converter,
    required this.databasePath,
  });

  Future<void> add(T value);
  Future<List<T>> getAll();
  Future<void> update(T value);
  Future<void> delete(T value);

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
