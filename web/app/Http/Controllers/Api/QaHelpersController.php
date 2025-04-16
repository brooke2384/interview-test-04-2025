<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\JsonResponse;

class QaHelpersController extends Controller
{
    public function createTestUser(): JsonResponse
    {
        $user = User::factory()->test_user()->create();

        return response()->json($user);
    }

    public function destroyAllTestUsers(): JsonResponse
    {
        User::where('is_test_user', true)->delete();

        return response()->json([]);
    }
}
