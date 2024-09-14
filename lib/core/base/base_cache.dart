import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'base_model.dart';

class SharedPref {
  final SharedPreferences sharedPreferences;

  SharedPref(this.sharedPreferences);

  Future<bool> setString(String key, String value) async {
    return sharedPreferences.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return sharedPreferences.getString(key);
  }

  Future<bool> setBool(String key, bool value) async {
    return sharedPreferences.setBool(key, value);
  }

  bool getBool(String key) {
    return sharedPreferences.getBool(key) ?? false;
  }

  Future<bool> setObject(BaseModel model, String key) async {
    final Map<String, dynamic> jsonMap = model.toJson();
    final jsonString = json.encode(jsonMap);
    return sharedPreferences.setString(key, jsonString);
  }

  Future<T?> getObject<T extends BaseModel>(String key, T model) async {
    final jsonString = sharedPreferences.getString(key);

    if (jsonString != null && jsonString.isNotEmpty) {
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return model.fromJson(jsonMap);
    } else {
      return null;
    }
  }

  Future<bool> clearAll() async {
    return sharedPreferences.clear();
  }

  Future<bool> removeKey(String key) async {
    return sharedPreferences.remove(key);
  }

  Future<Set<String>> getAllKeys() async {
    return sharedPreferences.getKeys();
  }

  bool containsKey(String key) {
    return sharedPreferences.containsKey(key);
  }
}
