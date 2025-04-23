import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:kmbal_movies_app/controllers/auth_controller.dart';
import 'package:kmbal_movies_app/models/api_response.dart';
import 'package:kmbal_movies_app/models/login_request.dart';
import 'package:kmbal_movies_app/models/login_response.dart';
import 'package:kmbal_movies_app/models/movie.dart';
import 'package:kmbal_movies_app/models/movies_index_response.dart';
import 'package:kmbal_movies_app/models/review.dart';
import 'package:kmbal_movies_app/models/reviews_index_response.dart';
import 'package:kmbal_movies_app/models/validation_error_response.dart';

/// Base API client with shared logic
abstract class _AbstractApiClient extends GetConnect {
  final AuthController _authController = Get.find();
  final String _apiBaseUrl = "http://localhost:8000/api";

  /// Formats full API URL
  String _url(String path) => "$_apiBaseUrl$path";

  /// Common headers
  Map<String, String> get _baseHeaders => {
        "Accept": "application/json",
      };

  /// Adds Bearer auth and optional extra headers like Content-Type
  Map<String, String> _headersWithAuth({Map<String, String>? extra}) => {
        ..._baseHeaders,
        "Authorization": "Bearer ${_authController.requireToken()}",
        if (extra != null) ...extra,
      };

  /// Converts raw [Response] into a typed [ApiResponse<T>]
  ApiResponse<T> _toApiResponse<T>(
    T Function(Map<String, dynamic>) fromJson,
    Response response,
  ) {
    if (response.status.isOk) {
      return ApiResponse.ok(response, fromJson(response.body));
    }

    if (response.statusCode == HttpStatus.unprocessableEntity ||
        response.statusCode == HttpStatus.badRequest) {
      return ApiResponse.validationError(
          response, ValidationErrorResponse.fromJson(response.body));
    }

    return ApiResponse.unknownError(response);
  }
}

/// Handles authentication
class ApiClient extends _AbstractApiClient {
  late final MoviesApiClient movies = MoviesApiClient();

  Future<ApiResponse<LoginResponse>> login(LoginRequest request) async {
    return _toApiResponse(
      LoginResponse.fromJson,
      await post(
        _url("/v1/login"),
        request.toJson(),
        headers: _baseHeaders,
      ),
    );
  }

  Future<ApiResponse<void>> logout() async {
    return _toApiResponse(
      (_) => null,
      await post(
        _url("/v1/logout"),
        null,
        headers: _headersWithAuth(),
      ),
    );
  }
}

/// Handles movie endpoints
class MoviesApiClient extends _AbstractApiClient {
  late final MovieReviewsApiClient reviews = MovieReviewsApiClient();

  Future<ApiResponse<MoviesIndexResponse>> index() async {
    return _toApiResponse(
      MoviesIndexResponse.fromJson,
      await get(
        _url("/v1/movies"),
        headers: _headersWithAuth(),
      ),
    );
  }

  Future<ApiResponse<Movie>> show(String id) async {
    return _toApiResponse(
      Movie.fromJson,
      await get(
        _url("/v1/movies/$id"),
        headers: _headersWithAuth(),
      ),
    );
  }
}

/// Handles review endpoints per movie
class MovieReviewsApiClient extends _AbstractApiClient {
  Future<ApiResponse<ReviewsIndexResponse>> index(String movieId) async {
    return _toApiResponse(
      ReviewsIndexResponse.fromJson,
      await get(
        _url("/v1/movies/$movieId/reviews"),
        headers: _headersWithAuth(),
      ),
    );
  }

  Future<ApiResponse<Review>> show(String movieId, String reviewId) async {
    return _toApiResponse(
      Review.fromJson,
      await get(
        _url("/v1/movies/$movieId/reviews/$reviewId"),
        headers: _headersWithAuth(),
      ),
    );
  }

  Future<ApiResponse<Review>> create(String movieId, Map<String, dynamic> data) async {
    return _toApiResponse(
      Review.fromJson,
      await post(
        _url("/v1/movies/$movieId/reviews"),
        data,
        headers: _headersWithAuth(extra: {"Content-Type": "application/json"}),
      ),
    );
  }

  Future<ApiResponse<Review>> update(String movieId, String reviewId, Map<String, dynamic> data) async {
    return _toApiResponse(
      Review.fromJson,
      await patch(
        _url("/v1/movies/$movieId/reviews/$reviewId"),
        data,
        headers: _headersWithAuth(extra: {"Content-Type": "application/json"}),
      ),
    );
  }

  Future<ApiResponse<void>> destroy(String movieId, String reviewId) async {
    return _toApiResponse(
      (_) => null,
      await delete(
        _url("/v1/movies/$movieId/reviews/$reviewId"),
        headers: _headersWithAuth(),
      ),
    );
  }
}
