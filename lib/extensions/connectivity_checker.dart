library connectivity_checker;

import 'package:get/get.dart';
import '../core/network/connectivity/internet_connectivity.dart';
import '../widgets/base_snackbar_widget.dart';

extension ConnectivityChecker on GetxController {
  void checkConnectivity() {
    RxBool isOnline = RxBool(true);
    final connection = Get.find<ConnectivityCheck>();
    connection.connectionStream.stream.listen((event) {
      isOnline(event);
    });
    ever(isOnline, (callback) => showSnackBar(callback ? "Online" : "Offline"));

    ever(isOnline, (callback) {});
  }
}
