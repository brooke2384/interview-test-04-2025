import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmbal_movies_app/controllers/reviews_controller.dart';
import 'package:kmbal_movies_app/models/review.dart';
import 'package:kmbal_movies_app/tokens.dart';

class ReviewForm extends StatefulWidget {
  final String movieId;

  const ReviewForm(this.movieId, {super.key});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final ReviewsController _reviewsController = Get.find();
  final TextEditingController _reviewController = TextEditingController();
  int _rating = 5;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Load existing review if it exists
    _loadExistingReview();
  }

  void _loadExistingReview() {
    final existingReview = _reviewsController.getUserReview(widget.movieId);
    if (existingReview != null) {
      _rating = existingReview.rating;
      _reviewController.text = existingReview.review;
    }
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (_reviewController.text.trim().isEmpty) {
      return;
    }

    final success = _isEditing
        ? await _reviewsController.updateReview(
            widget.movieId,
            _reviewsController.getUserReview(widget.movieId)!.id.toString(),
            _rating,
            _reviewController.text.trim(),
          )
        : await _reviewsController.submitReview(
            widget.movieId,
            _rating,
            _reviewController.text.trim(),
          );

    if (success) {
      _reviewController.clear();
      setState(() {
        _rating = 5;
        _isEditing = false;
      });
    }
  }

  Future<void> _deleteReview() async {
    final review = _reviewsController.getUserReview(widget.movieId);
    if (review == null) return;

    final success = await _reviewsController.deleteReview(
      widget.movieId,
      review.id.toString(),
    );

    if (success) {
      _reviewController.clear();
      setState(() {
        _rating = 5;
        _isEditing = false;
      });
    }
  }

  Widget _buildExistingReview(Review review) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: ColorTokens.lightBlue100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Your Review',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) {
              final rating = index + 1;
              return Icon(
                rating <= review.rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(review.review),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _isEditing = true;
                    _rating = review.rating;
                    _reviewController.text = review.review;
                  });
                },
                child: const Text('Edit'),
              ),
              TextButton(
                onPressed: _deleteReview,
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReviewForm() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: ColorTokens.lightBlue100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _isEditing ? 'Edit Review' : 'Write a Review',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (index) {
              final rating = index + 1;
              return IconButton(
                onPressed: () => setState(() => _rating = rating),
                icon: Icon(
                  rating <= _rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _reviewController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Write your review here...',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          if (_reviewsController.error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                _reviewsController.error.value,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_isEditing)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = false;
                      _loadExistingReview();
                    });
                  },
                  child: const Text('Cancel'),
                ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed:
                    _reviewsController.isSubmitting.value ? null : _submitReview,
                child: Text(
                  _reviewsController.isSubmitting.value
                      ? 'Submitting...'
                      : _isEditing
                          ? 'Update Review'
                          : 'Submit Review',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hasReviewed = _reviewsController.hasUserReviewedMovie(widget.movieId);
      final review = _reviewsController.getUserReview(widget.movieId);

      // If user has reviewed and not editing, show only their review with edit/delete options
      if (hasReviewed && !_isEditing && review != null) {
        return _buildExistingReview(review);
      }

      // If user hasn't reviewed yet or is editing their review, show the form
      if (!hasReviewed || _isEditing) {
        return _buildReviewForm();
      }

      // If user has reviewed but review is not loaded yet, show nothing
      return const SizedBox.shrink();
    });
  }
}
