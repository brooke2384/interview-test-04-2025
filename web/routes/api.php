<?php

use Illuminate\Support\Facades\Route;

Route::prefix('qa')->name('api.qa.')->group(base_path('routes/api/qa.php'));
Route::prefix('v1')->name('api.v1.')->group(base_path('routes/api/v1.php'));
