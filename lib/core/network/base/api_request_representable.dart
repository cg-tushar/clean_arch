library api_request_representable;


enum HTTPMethod { get, post, delete, put, patch }


// * Type of Request we are performing

abstract class APIRequestRepresentable {
  String get URL;
  bool get cache;
  String get endpoint;
  HTTPMethod get method;
  Map<String, String>? get headers;
  Map<String, String>? get query;
  dynamic get body;
  Stream request();
}
