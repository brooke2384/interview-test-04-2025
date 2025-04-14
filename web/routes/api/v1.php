<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\MovieReviewsController;
use App\Http\Controllers\Api\MoviesController;
use Illuminate\Support\Facades\Route;

Route::post('/login', [AuthController::class, 'login'])->name('login');

Route::middleware('auth:api')->group(function () {
  Route::post('logout', [AuthController::class, 'logout'])->name('logout');

  Route::resource('movies', MoviesController::class);
  Route::resource('movies.reviews', MovieReviewsController::class);
});
