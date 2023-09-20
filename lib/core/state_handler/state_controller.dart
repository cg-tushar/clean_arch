library state_controller;

import 'dart:async';
import 'package:get/get.dart' hide Response;
import '../../services/logger_service.dart';
import '../../widgets/base_snackbar_widget.dart';
import '../database/storage.dart';
import '../network/base/response_handler.dart';
import '../network/connectivity/internet_connectivity.dart';

// ? Super Controller to handle states and errors with connectivity checks

abstract class StateController<T, P> extends GetxController {
  T? stateController;

  late Rx<NetworkResponse<P>> state = NetworkResponse<P>.idle().obs;

  networkCalls(Stream<NetworkResponse<P>> Function() method) async {
    state.value = NetworkResponse<P>.loading(); // Set state to loading when the network call starts
    method().listen(
      (event) {
        LoggerService.instance.e(event.networkState.toString(), tag: "StateController[event]");
        state.value = _handleEvent(event);
        update();
      },
      onError: (e) {
        LoggerService.instance.e(e.toString(), tag: "StateController[onError]");
        state.value = NetworkResponse<P>.error(error: e.toString());
      },
    );
  }
  NetworkResponse<P> _handleEvent(NetworkResponse<P> event) {
    if (event.networkState == NetworkState.loading) {
      return NetworkResponse<P>.loading();
    } else if (event.networkState == NetworkState.success) {
      return NetworkResponse<P>.success(data: event.data);
    } else if (event.networkState == NetworkState.error) {
      return NetworkResponse<P>.error(error: event.error);
    } else {
      return NetworkResponse<P>.idle();
    }
  }
}

class SuperStateController<T, P> extends StateController<T, P> {
  @override
  void onInit() {
    checkConnectivity();
    super.onInit();
  }
}

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
