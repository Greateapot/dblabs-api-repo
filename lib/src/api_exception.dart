import 'package:dblabs_api/dblabs_api.dart' show ResponseError;

class ApiException implements Exception {
  final String message;
  final int code;

  ApiException({required this.code, required this.message});

  factory ApiException.fromResponseError(ResponseError error) => ApiException(
        code: error.code,
        message: error.message,
      );

  @override
  String toString() => 'ApiException($code): $message';
}
