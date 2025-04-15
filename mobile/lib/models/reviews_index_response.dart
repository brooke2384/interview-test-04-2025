import 'package:json_annotation/json_annotation.dart';
import 'package:kmbal_movies_app/models/review.dart';

part 'reviews_index_response.g.dart';

@JsonSerializable()
class ReviewsIndexResponse {
  final List<Review> reviews;

  ReviewsIndexResponse({required this.reviews});

  factory ReviewsIndexResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewsIndexResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewsIndexResponseToJson(this);
}
