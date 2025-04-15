// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_index_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesIndexResponse _$MoviesIndexResponseFromJson(Map<String, dynamic> json) =>
    MoviesIndexResponse(
      movies: (json['movies'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MoviesIndexResponseToJson(
        MoviesIndexResponse instance) =>
    <String, dynamic>{
      'movies': instance.movies,
    };
