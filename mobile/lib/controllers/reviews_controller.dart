import 'package:get/get.dart';
import 'package:kmbal_movies_app/controllers/auth_controller.dart';
import 'package:kmbal_movies_app/models/api_response.dart';
import 'package:kmbal_movies_app/models/review.dart';
import 'package:kmbal_movies_app/services/api_client.dart';

class ReviewsController extends GetxController {
  final ApiClient _apiClient = Get.find();
  final AuthController _authController = Get.find();
  final RxBool isSubmitting = false.obs;
  final RxString error = ''.obs;
  final RxMap<String, Review> userReviews = <String, Review>{}.obs;

  @override
  void onInit() {
    super.onInit();

    // Clear reviews when auth state changes
    ever<bool>(_authController.isAuthenticated, (bool isAuthenticated) {
      if (!isAuthenticated) {
        userReviews.clear();
      }
    });
  }

  Future<void> loadReviews(String movieId) async {
    try {
      final response = await _apiClient.movies.reviews.index(movieId);

      if (response.kind == ApiResponseKind.ok) {
        final currentUserId = _authController.user?.id;

        if (currentUserId == null) {
          print('User not authenticated');
          return;
        }

        userReviews.remove(movieId); // Clear previous entry if exists

        // Add user's review to map if found
        for (final review in response.data!.reviews) {
          if (review.userId == currentUserId) {
            userReviews[movieId] = review;
            break;
          }
        }
      }
    } catch (e) {
      print('Error loading reviews: $e');
      error.value = 'Failed to load reviews';
    }
  }

  Future<bool> submitReview(String movieId, int rating, String review) async {
    if (userReviews.containsKey(movieId)) {
      error.value = 'You have already reviewed this movie';
      return false;
    }

    if (rating < 1 || rating > 5) {
      error.value = 'Rating must be between 1 and 5';
      return false;
    }

    isSubmitting.value = true;
    error.value = '';

    try {
      final response = await _apiClient.movies.reviews.create(
        movieId,
        {
          'rating': rating,
          'review': review,
        },
      );

      if (response.kind == ApiResponseKind.ok) {
        userReviews[movieId] = response.data!;
        return true;
      } else if (response.kind == ApiResponseKind.validationError) {
        error.value = response.validationError!.message;
      } else {
        error.value = 'Failed to submit review';
      }
    } catch (e) {
      error.value = 'An error occurred while submitting the review';
    } finally {
      isSubmitting.value = false;
    }

    return false;
  }

  Future<bool> updateReview(String movieId, String reviewId, int rating, String review) async {
    isSubmitting.value = true;
    error.value = '';

    try {
      final response = await _apiClient.movies.reviews.update(
        movieId,
        reviewId,
        {
          'rating': rating,
          'review': review,
        },
      );

      if (response.kind == ApiResponseKind.ok) {
        userReviews[movieId] = response.data!;
        return true;
      } else if (response.kind == ApiResponseKind.validationError) {
        error.value = response.validationError!.message;
      } else {
        error.value = 'Failed to update review';
      }
    } catch (e) {
      error.value = 'An error occurred while updating the review';
    } finally {
      isSubmitting.value = false;
    }

    return false;
  }

  Future<bool> deleteReview(String movieId, String reviewId) async {
    try {
      final response = await _apiClient.movies.reviews.destroy(movieId, reviewId);
      if (response.kind == ApiResponseKind.ok) {
        userReviews.remove(movieId);
        return true;
      }
      error.value = 'Failed to delete review';
    } catch (e) {
      error.value = 'An error occurred while deleting the review';
    }

    return false;
  }

  bool hasUserReviewedMovie(String movieId) {
    return userReviews.containsKey(movieId);
  }

  Review? getUserReview(String movieId) {
    return userReviews[movieId];
  }
}
