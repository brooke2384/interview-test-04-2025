// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: (json['id'] as num).toInt(),
      movieId: (json['movie_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      rating: (json['rating'] as num).toInt(),
      review: json['review'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'movie_id': instance.movieId,
      'user_id': instance.userId,
      'rating': instance.rating,
      'review': instance.review,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
