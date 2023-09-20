library no_param_usecase;

import '../network/base/response_handler.dart';

abstract class NoParamUseCase<ResponseType> {
  Stream<NetworkResponse<ResponseType>> execute();
}
