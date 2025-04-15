import 'package:get/get.dart';
import 'package:kmbal_movies_app/models/api_response.dart';
import 'package:kmbal_movies_app/models/movie.dart';
import 'package:kmbal_movies_app/models/review.dart';
import 'package:kmbal_movies_app/services/api_client.dart';

class MoviesController extends GetxController {
  final ApiClient _apiClient = Get.find();

  Future<List<Movie>> fetchMovies() async {
    final response = await _apiClient.movies.index();

    if (response.kind == ApiResponseKind.ok) {
      return response.data!.movies;
    }

    throw Exception("Failed to fetch movies");
  }

  Future<Movie> fetchMovie(String id) async {
    final response = await _apiClient.movies.show(id);

    if (response.kind == ApiResponseKind.ok) {
      return response.data!;
    }

    throw Exception("Failed to fetch movies");
  }

  Future<List<Review>> fetchMovieReviews(String movieId) async {
    final response = await _apiClient.movies.reviews.index(movieId);

    if (response.kind == ApiResponseKind.ok) {
      return response.data!.reviews;
    }

    throw Exception("Failed to fetch movie reviews");
  }
}