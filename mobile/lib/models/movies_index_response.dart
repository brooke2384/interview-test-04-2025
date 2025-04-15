import 'package:json_annotation/json_annotation.dart';
import 'package:kmbal_movies_app/models/movie.dart';

part 'movies_index_response.g.dart';

@JsonSerializable()
class MoviesIndexResponse {
  final List<Movie> movies;

  MoviesIndexResponse({required this.movies});

  factory MoviesIndexResponse.fromJson(Map<String, dynamic> json) =>
      _$MoviesIndexResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MoviesIndexResponseToJson(this);
}
