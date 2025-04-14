<?php

namespace App\Http\Controllers;

use App\Models\Movie;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class MoviesController extends Controller
{
    /**
     * Show the movies.
     */
    public function index(Request $request): Response
    {
        return Inertia::render('Movies/Index', [
            'movies' => Movie::all(),
        ]);
    }

    /**
     * Show a movie.
     */
    public function show(Request $request, String $slug): Response
    {
        return Inertia::render('Movies/Show', [
            'movie' => Movie::where('slug', $slug)->with('reviews.user')->firstOrFail(),
        ]);
    }
}
