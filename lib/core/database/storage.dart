import 'package:shared_preferences/shared_preferences.dart';

import 'interfaces/local_db_interface.dart';

class LocalStorage implements BaseLocalStorageInterface {
  final SharedPreferences _sharedPreferences;

  static LocalStorage? _singleton;

  factory LocalStorage() {
    if (_singleton == null) {
      throw Exception("Must call init() before using this singleton");
    }
    return _singleton!;
  }

  LocalStorage._(this._sharedPreferences);

  static Future<void> init() async {
    if (_singleton == null) {
      final prefs = await SharedPreferences.getInstance();
      _singleton = LocalStorage._(prefs);
    }
  }

@override
  Future<void> writeSecureData(StorageItem newItem) async {
    await _sharedPreferences.setString(newItem.key, newItem.value);
  }

  @override
  Future<String?> readSecureData(String key) async {
    String? readData = _sharedPreferences.getString(key);
    return readData;
  }

  @override
  Future<void> deleteSecureData(String key) async {
    await _sharedPreferences.remove(key);
  }

  @override
  Future<bool> containsKeyInSecureData(String key) async {
    bool containsKey = _sharedPreferences.containsKey(key);
    return containsKey;
  }

  @override
  Future<void> deleteAllSecureData() async {
    await _sharedPreferences.clear();
  }

  @override
  Future<List<StorageItem>> readAllSecureData() {
    // TODO: implement readAllSecureData
    throw UnimplementedError();
  }
}
