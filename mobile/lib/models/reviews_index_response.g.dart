// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_index_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsIndexResponse _$ReviewsIndexResponseFromJson(
        Map<String, dynamic> json) =>
    ReviewsIndexResponse(
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewsIndexResponseToJson(
        ReviewsIndexResponse instance) =>
    <String, dynamic>{
      'reviews': instance.reviews,
    };
