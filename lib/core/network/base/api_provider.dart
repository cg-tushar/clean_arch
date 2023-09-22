library api_provider;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clean_arch/extensions/http_string.dart';
import 'package:get/get_connect/connect.dart';

import '../../../services/logger_service.dart';
import '../../../widgets/base_snackbar_widget.dart';
import '../../database/get_key.dart';
import '../../database/interfaces/local_db_interface.dart';
import '../../database/storage.dart';
import 'api_exceptions.dart';
import 'api_request_representable.dart';

class APIProvider {
  static const requestTimeOut = Duration(seconds: 25);
  final _client = GetConnect(timeout: requestTimeOut);
  static final _singleton = APIProvider._();
  static APIProvider get instance => _singleton;
  final _cacheKeyGenerator = CacheKeyGenerator();

  APIProvider._();

  Stream<Response> request(APIRequestRepresentable request) async* {
    try {
      if (request.cache) {
        final localItem = await LocalStorage.instance.readSecureData(_cacheKeyGenerator.generate(request.endpoint, request.query));
        if (localItem != null) {
          LoggerService.instance
              .logLocalResponse(data: localItem, key: _cacheKeyGenerator.generate(request.endpoint, request.query));
          yield Response(body: jsonDecode(localItem), statusCode: 200);
        }
      }
      final response = await _client.request(request.URL+request.endpoint, request.method.string,
          headers: request.headers, query: request.query, body: request.body);
      LoggerService.instance.logNetworkResponse(response);
      // LoggerService.networkLogWriter(response,isError: response.hasError);
      if (response.isOk) {
        LocalStorage.instance
            .writeSecureData(StorageItem(_cacheKeyGenerator.generate(request.endpoint, request.query), jsonEncode(response.body)));
        yield response;
      } else {
        showSnackBar(response.bodyString ?? "",isError: true);
        yield response;
      }
    } on TimeoutException catch (_) {
      LoggerService.instance.e(_.message ?? "TimeoutException", tag: "APi Provider:TimeoutException");
      throw TimeOutException(null);
    } on SocketException {
      LoggerService.instance.e('No Internet connection', tag: "APi Provider:SocketException");
      throw FetchDataException('No Internet connection');
    }
  }
}
