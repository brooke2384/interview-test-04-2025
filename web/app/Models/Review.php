<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Review extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'movie_id',
        'user_id',
        'rating',
        'review',
    ];

    /**
     * Get the movie associated with the review.
     */
    public function movie(): BelongsTo
    {
        return $this->belongsTo(Movie::class);
    }

    /**
     * Get the user associated with the review.
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}
