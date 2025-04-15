import 'package:json_annotation/json_annotation.dart';

part 'validation_error_response.g.dart';

@JsonSerializable()
class ValidationErrorResponse {
  final String message;
  final Map<String, List<String>>? errors;

  ValidationErrorResponse({required this.message, required this.errors});

  factory ValidationErrorResponse.fromJson(Map<String, dynamic> json) => _$ValidationErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ValidationErrorResponseToJson(this);
}
