<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Movie;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class MoviesController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): JsonResponse
    {
        return response()->json([
            'movies' => Movie::all(),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        return response()->json([
            'message' => 'Forbidden',
        ], 403);
    }

    /**
     * Display the specified resource.
     */
    public function show(int $id)
    {
        $movie = Movie::find($id);

        if (!$movie) {
            return response()->json([
                'message' => 'Not found',
            ], 404);
        }

        return response()->json($movie);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        return response()->json([
            'message' => 'Forbidden',
        ], 403);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        return response()->json([
            'message' => 'Forbidden',
        ], 403);
    }
}
