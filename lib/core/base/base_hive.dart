import 'package:hive/hive.dart';

class HiveStorage {
  late Box _box;
  Future<void> clearAll() async {
    await _box.clear();
  }

  Future<void> clearAllBoxes() async {
    await Hive.close();
    await Hive.deleteFromDisk();
  }

  Future<void> closeBox() async {
    await _box.close();
  }

  T? get<T>(dynamic key) {
    return _box.get(key) as T?;
  }

  Future<void> initBloc(String boxName) async {
    await _init(boxName);
  }

  Future<void> remove(dynamic key) async {
    await _box.delete(key);
  }

  Future<void> set(dynamic key, dynamic value) async {
    await _box.put(key, value);
  }

  Future<void> _init(String boxName) async {
    _box = await Hive.openBox(boxName);
  }
}
