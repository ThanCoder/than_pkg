// ignore_for_file: public_member_api_docs, sort_constructors_first
mixin TDatabaseListener {
  void onDatabaseChanged(TDatabaseListenerTypes type, String? id);
}

enum TDatabaseListenerTypes { add, update, delete, saved }

abstract class TDatabase<T> {
  final String root;
  TDatabase({required this.root});

  Future<void> add(T value);
  Future<List<T>> getAll({Map<String, dynamic>? query});
  Future<void> update(String id, T value);
  Future<void> delete(String id);

  // listener
  final List<TDatabaseListener> _listeners = [];

  // register/unregister methods
  void addListener(TDatabaseListener listener) {
    _listeners.add(listener);
  }

  void removeListener(TDatabaseListener listener) {
    _listeners.remove(listener);
  }

  void notify(TDatabaseListenerTypes type, String? id) {
    for (final listener in _listeners) {
      listener.onDatabaseChanged(type, id);
    }
  }
}
