import 'package:get/get.dart';
import 'package:kmbal_movies_app/models/validation_error_response.dart';

enum ApiResponseKind {
  ok,
  validationError,
  unknownError,
}

class ApiResponse<TData> {
  final ApiResponseKind kind;
  final TData? data;
  final ValidationErrorResponse? validationError;
  final Response response;

  ApiResponse._({
    required this.kind,
    required this.data,
    required this.validationError,
    required this.response,
  });

  factory ApiResponse.ok(Response response, TData data) => ApiResponse._(
    kind: ApiResponseKind.ok,
    data: data,
    validationError: null,
    response: response,
  );

  factory ApiResponse.validationError(Response response, ValidationErrorResponse validationError) => ApiResponse._(
    kind: ApiResponseKind.validationError,
    data: null,
    validationError: validationError,
    response: response,
  );

  factory ApiResponse.unknownError(Response response) => ApiResponse._(
    kind: ApiResponseKind.unknownError,
    data: null,
    validationError: null,
    response: response,
  );
}