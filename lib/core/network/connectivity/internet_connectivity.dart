import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityCheck {
  static final ConnectivityCheck instance = ConnectivityCheck._();
  static final Connectivity _connectivity = Connectivity();
  ConnectivityCheck._();
  final connectionStream = StreamController<bool>.broadcast();
  get isConnected => checkConnection();

  // * checking internet connection

  initConnectionCheck() {
    _connectivity.onConnectivityChanged.listen((event) {
      connectionStream.add((event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi));
    });
  }

  checkConnection() async {
    final connection = await _connectivity.checkConnectivity();
    return (connection == ConnectivityResult.mobile ||
        connection == ConnectivityResult.wifi);
  }
}
