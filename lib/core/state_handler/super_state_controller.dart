library super_state_controller;
import 'state_controller.dart';


class SuperStateController<T, P> extends StateController<T, P> {
  @override
  void onInit() {
    checkConnectivity();
    super.onInit();
  }
}
