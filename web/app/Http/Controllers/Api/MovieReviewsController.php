<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Api\StoreMovieReviewRequest;
use App\Http\Requests\Api\UpdateMovieReviewRequest;
use App\Models\Review;
use Illuminate\Support\Facades\Auth;

class MovieReviewsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(int $movie_id)
    {
        return response()->json([
            'reviews' => Review::where('movie_id', $movie_id)->get(),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreMovieReviewRequest $request, int $movie_id)
    {
        $data = $request->safe();

        $conflict = Review::where([
            ['movie_id', '=', $movie_id],
            ['user_id', '=', Auth::id()],
        ])->exists();

        if ($conflict) {
            return response()->json([
                'message' => 'You have already submitted a review for this movie.',
            ], 409);
        }

        $review = Review::create([
            'movie_id' => $movie_id,
            'user_id' => Auth::id(),
            'rating' => $data['rating'],
            'review' => $data['review'],
        ]);

        return response()->json($review);
    }

    /**
     * Display the specified resource.
     */
    public function show(int $movie_id, int $review_id)
    {
        $review = Review::where([
            ['id', '=', $review_id],
            ['movie_id', '=', $movie_id],
        ])->first();

        if (!$review) {
            return response()->json([
                'message' => 'The review was not found.',
            ], 404);
        }

        return response()->json($review);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateMovieReviewRequest $request, int $movie_id, int $review_id)
    {
        $review = Review::where([
            ['id', '=', $review_id],
            ['movie_id', '=', $movie_id],
        ])->first();

        if (!$review) {
            return response()->json([
                'message' => 'The review was not found.',
            ], 404);
        }

        if ($review->user_id !== Auth::id()) {
            return response()->json([
                'message' => 'You do not have permission to delete this review.',
            ], 403);
        }

        $review->update($request->only(['rating', 'review']));

        return response()->json($review);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(int $movie_id, int $review_id)
    {
        $review = Review::where([
            ['id', '=', $review_id],
            ['movie_id', '=', $movie_id],
        ])->first();

        if (!$review) {
            return response()->json([
                'message' => 'The review was not found.',
            ], 404);
        }

        if ($review->user_id !== Auth::id()) {
            return response()->json([
                'message' => 'You do not have permission to delete this review.',
            ], 403);
        }

        return response()->json([
            'data' => $review->delete(),
        ]);
    }
}
