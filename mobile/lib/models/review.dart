import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  final int id;
  @JsonKey(name: 'movie_id')
  final int movieId;
  @JsonKey(name: 'user_id')
  final int userId;
  final int rating;
  final String review;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  Review({
    required this.id,
    required this.movieId,
    required this.userId,
    required this.rating,
    required this.review,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);


}
