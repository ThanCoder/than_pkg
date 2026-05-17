abstract class TConverter<T,V> {
  T from(V value);
  V to(T value);
}

abstract class JsonConverter<T> extends TConverter<T, Map<String, dynamic>> {}
