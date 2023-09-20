library local_cleaner;
import 'package:get/get.dart';

import '../core/database/storage.dart';

extension LocalStorageCleaner on GetxController {
  void clearLocalStorage({String? key}) {
    LocalStorage localStorageInstance = Get.find<LocalStorage>();
    if (key == null) {
      localStorageInstance.deleteAllSecureData();
    } else {
      localStorageInstance.deleteSecureData(key);
    }
  }
}
