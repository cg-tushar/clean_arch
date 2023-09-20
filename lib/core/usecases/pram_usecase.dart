
library param_usecase;

import '../network/base/response_handler.dart';

abstract class ParamUseCase<ResponseType, Params> {
  Stream<NetworkResponse<ResponseType>> execute({required Params params});
}
