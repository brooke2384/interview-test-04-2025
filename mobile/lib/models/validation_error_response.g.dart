// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation_error_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidationErrorResponse _$ValidationErrorResponseFromJson(
        Map<String, dynamic> json) =>
    ValidationErrorResponse(
      message: json['message'] as String,
      errors: (json['errors'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$ValidationErrorResponseToJson(
        ValidationErrorResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errors': instance.errors,
    };
