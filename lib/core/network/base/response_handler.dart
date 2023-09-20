library response_handler;
import 'package:get/get_connect.dart' as get_connect;
import 'package:get/instance_manager.dart';
import '../../model/base_model.dart';

// * Handles the network response

class NetworkResponseHandler<P extends BaseModel> {


  NetworkResponse<P> response(get_connect.Response response) {
    switch (response.statusCode) {
      case 0:
        return NetworkResponse<P>.loading();
      case 200:
        return NetworkResponse<P>.success(data: Get.find<P>().fromJson(response.body));
      default:
        return NetworkResponse<P>.error(
          error: response.statusText,
          statusCode: response.statusCode ?? 0,
          isError: true,
        );
    }
  }
  // if(response.isOk){
  //   switch (response.statusCode) {
  //     case 200:
  //       return NetworkResponse<P>.success(data: Get.find<P>().fromJson(response.body));
  //     default:
  //       return NetworkResponse<P>.loading(
  //         error: response.statusPext,
  //         statusCode: response.statusCode ?? 0,
  //         isError: false,
  //       );
  //   }
  // }
  // else{
  //   return  NetworkResponse<P>.loading(
  //   error: response.statusPext,
  // statusCode: response.statusCode ?? 0,
  // isError: false,
  // )
  // }
  // }
}

class NetworkResponse<P> {
  P? data;
  int? statusCode;
  String? error;
  bool isError;
  NetworkState networkState;

  NetworkResponse.idle(
      {this.data, this.error = '', this.statusCode = 0, this.isError = false, this.networkState = NetworkState.idle});
  NetworkResponse.loading({this.error = '', this.statusCode = 0, this.isError = false, this.networkState = NetworkState.loading});
  NetworkResponse.success(
      {this.error = '', required this.data, this.statusCode = 0, this.isError = false, this.networkState = NetworkState.success});
  NetworkResponse.error({required this.error, this.statusCode = 0, this.isError = true, this.networkState = NetworkState.error});
}

enum NetworkState { loading, success, error, idle }
