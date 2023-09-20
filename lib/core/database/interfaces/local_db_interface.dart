abstract class BaseLocalStorageInterface {
  /// writing data into secure storage
  Future<void> writeSecureData(StorageItem newItem);

  /// read the secured data concerning the key
  Future<String?> readSecureData(String key);

  /// delete a key-value pair
  Future<void> deleteSecureData(String key);

  /// checking whether the storage contains the provided key or not
  Future<bool> containsKeyInSecureData(String key);

  /// read all the secured data
  Future<List<StorageItem>> readAllSecureData();

  /// to delete all the secured data
  Future<void> deleteAllSecureData();
}

class StorageItem {
  StorageItem(this.key, this.value);

  final String key;
  final String value;
}
