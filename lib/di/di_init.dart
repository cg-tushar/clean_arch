import 'package:clean_arch/core/database/storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/network/connectivity/internet_connectivity.dart';

class DependencyInjector {
  // * injecting dependency and initializing the storage
  static init() async {
    LocalStorage.init();
    ConnectivityCheck.instance.initConnectionCheck();
    Get.put(ConnectivityCheck.instance);
  }
}