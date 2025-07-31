class MapServices {
  static String getString(
    Map<String, dynamic> map,
    List<String> keys, {
    String defaultValue = '',
  }) {
    return get<String>(map, keys, defaultValue: defaultValue);
  }

  static double getDouble(
    Map<String, dynamic> map,
    List<String> keys, {
    double defaultValue = 0.0,
  }) {
    return get<double>(map, keys, defaultValue: defaultValue);
  }

  static int getInt(
    Map<String, dynamic> map,
    List<String> keys, {
    int defaultValue = 0,
  }) {
    return get<int>(map, keys, defaultValue: defaultValue);
  }

  static T get<T>(
    Map<String, dynamic> map,
    List<String> keys, {
    required T defaultValue,
  }) {
    dynamic current = map;
    for (var key in keys) {
      // if (current is Map<String, dynamic>) {
      //   print(current);
      //   print(current.containsKey(key));
      // }

      if (current is Map<String, dynamic> && current.containsKey(key)) {
        current = current[key];
      }
    }
    // string ကိုယူမှာ
    if (T == String && current is int) {
      current = current.toString();
    }
    if (T == String && current is double) {
      current = current.toString();
    }
    // int ကိုယူမှာ
    if (T == int && current is String) {
      if (int.tryParse(current) != null) {
        current = int.parse(current);
      }
    }
    // double ကိုယူမှာ
    if (T == double && current is String) {
      if (double.tryParse(current) != null) {
        current = double.parse(current);
      }
    }
    // custom type အတွက်မရေးထားဘူး

    return current is T ? current : defaultValue;
  }
}
