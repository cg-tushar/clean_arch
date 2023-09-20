import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'interfaces/local_db_interface.dart';


class LocalStorage implements BaseLocalStorageInterface {
  static final LocalStorage instance = LocalStorage._();
  static late final FlutterSecureStorage _secureStorage;

  LocalStorage._();

  // final IOSOptions options = const IOSOptions(accessibility: KeychainAccessibility.first_unlock);
  // IOSOptions _getIosOptions() => const IOSOptions();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  initialize() {
    _secureStorage = const FlutterSecureStorage();
  }

  @override
  Future<void> writeSecureData(StorageItem newItem) async {
    await _secureStorage.write(
        key: newItem.key, value: newItem.value, aOptions: _getAndroidOptions());
  }

  @override
  Future<String?> readSecureData(String key) async {
    String? readData =
        await _secureStorage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }

  @override
  Future<void> deleteSecureData(String key) async {
    await _secureStorage.delete(key: key, aOptions: _getAndroidOptions());
  }

  @override
  Future<bool> containsKeyInSecureData(String key) async {
    bool containsKey = await _secureStorage.containsKey(
        key: key, aOptions: _getAndroidOptions());
    return containsKey;
  }

  @override
  Future<List<StorageItem>> readAllSecureData() async {
    Map<String, String> allData =
        await _secureStorage.readAll(aOptions: _getAndroidOptions());
    List<StorageItem> list =
        allData.entries.map((e) => StorageItem(e.key, e.value)).toList();
    return list;
  }

  @override
  Future<void> deleteAllSecureData() async {
    await _secureStorage.deleteAll(aOptions: _getAndroidOptions());
    log("Local Data Deleted Successfully");
  }
}
