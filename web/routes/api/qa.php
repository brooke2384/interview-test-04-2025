<?php

use App\Http\Controllers\Api\QaHelpersController;
use Illuminate\Support\Facades\Route;

// NOTE: These routes are for testing purposes only

Route::post('/createTestUser', [QaHelpersController::class, 'createTestUser'])
  ->name('createTestUser');
Route::delete('/destroyAllTestUsers', [QaHelpersController::class, 'destroyAllTestUsers'])
  ->name('destroyAllTestUsers');
