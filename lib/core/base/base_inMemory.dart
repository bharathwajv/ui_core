class InMemoryStorage {
  final Map<String, dynamic> _store = {};

  void clearAll() {
    _store.clear();
  }

  dynamic get(String key) {
    return _store[key];
  }

  T getType<T>(String key) {
    return _store[key];
  }

  void set(String key, dynamic value) {
    _store[key] = value;
  }
}
