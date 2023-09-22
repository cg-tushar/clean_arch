library super_state_controller;

import 'package:clean_arch/extensions/connectivity_checker.dart';
import 'state_controller.dart';


class SuperStateController<P> extends StateController<P> {
  @override
  void onInit() {
    checkConnectivity();
    super.onInit();
  }
}
