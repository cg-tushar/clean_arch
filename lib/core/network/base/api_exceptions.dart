library api_exceptions;

class AppException implements Exception {
  final String codeText;
  final String message;
  final String details;

  AppException(
      {required this.codeText, required this.message, required this.details});

  @override
  String toString() {
    return "[$codeText]: $message \n $details";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String? details)
      : super(
          codeText: "fetch-data",
          message: "Error During Communication",
          details: details ?? "",
        );
}

class BadRequestException extends AppException {
  BadRequestException(String? details)
      : super(
          codeText: "invalid-request",
          message: "Invalid Request",
          details: details ?? "",
        );
}

class UnauthorisedException extends AppException {
  UnauthorisedException(String? details)
      : super(
          codeText: "unauthorised",
          message: "Unauthorised",
          details: details ?? "",
        );
}

class InvalidInputException extends AppException {
  InvalidInputException(String? details)
      : super(
          codeText: "invalid-input",
          message: "Invalid Input",
          details: details ?? "",
        );
}

class AuthenticationException extends AppException {
  AuthenticationException(String? details)
      : super(
          codeText: "authentication-failed",
          message: "Authentication Failed",
          details: details ?? "",
        );
}

class TimeOutException extends AppException {
  TimeOutException(String? details)
      : super(
          codeText: "request-timeout",
          message: "Request TimeOut",
          details: details ?? '',
        );
}
