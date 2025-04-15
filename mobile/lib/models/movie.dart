
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final int id;
  final String slug;
  final String title;
  final String description;
  final DateTime released;

  Movie({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.released,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}