<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\EventController;
use App\Http\Controllers\NewsController;
use App\Http\Controllers\AchievementController;
use App\Http\Controllers\CandidateController;
use App\Http\Controllers\FundraiserController;
use App\Http\Controllers\GalleryController;
use App\Http\Controllers\ResourceController;
use App\Http\Controllers\CommunityGroupController;
use App\Http\Controllers\TVStationController;
use App\Http\Controllers\RadioStationController;
use App\Http\Controllers\ContactController;
use App\Http\Controllers\QuestionController;
use App\Http\Controllers\LocationController;
use App\Http\Controllers\LeaderController;

Route::post('register', [AuthController::class, 'register']);
Route::post('login', [AuthController::class, 'login']);

// Public read endpoints are consumed by the Flutter app. Content management
// writes remain behind Sanctum when Sanctum is installed in the deployment.
Route::get('events', [EventController::class, 'index']);
Route::get('events/{event}', [EventController::class, 'show']);
Route::get('news', [NewsController::class, 'index']);
Route::get('news/{news}', [NewsController::class, 'show']);
Route::get('achievements', [AchievementController::class, 'index']);
Route::get('achievements/{achievement}', [AchievementController::class, 'show']);
Route::get('candidates', [CandidateController::class, 'index']);
Route::get('candidates/{candidate}', [CandidateController::class, 'show']);
Route::get('fundraisers', [FundraiserController::class, 'index']);
Route::get('gallery', [GalleryController::class, 'index']);
Route::get('resources', [ResourceController::class, 'index']);
Route::get('community-groups', [CommunityGroupController::class, 'index']);
Route::get('tv-stations', [TVStationController::class, 'index']);
Route::get('radio-stations', [RadioStationController::class, 'index']);
Route::get('locations', [LocationController::class, 'index']);
Route::get('leaders', [LeaderController::class, 'index']);
Route::get('leaders/{leader}', [LeaderController::class, 'show']);

Route::middleware('api.token')->group(function () {
    // ->except(['index', 'show']) is required: Laravel's route collection keys
    // routes by [method][uri], so an apiResource's GET index/show here would
    // silently overwrite the public GET routes registered above, making every
    // "public" read endpoint require auth. Writes stay protected; reads stay public.
    // These have a public index AND show route above, so both must be excepted here.
    Route::apiResource('events', EventController::class)->except(['index', 'show']);
    Route::apiResource('news', NewsController::class)->except(['index', 'show']);
    Route::apiResource('achievements', AchievementController::class)->except(['index', 'show']);
    Route::apiResource('candidates', CandidateController::class)->except(['index', 'show']);
    Route::apiResource('leaders', LeaderController::class)->except(['index', 'show']);
    // These only have a public index above, so 'show' stays here (auth-protected).
    Route::apiResource('fundraisers', FundraiserController::class)->except(['index']);
    Route::apiResource('gallery', GalleryController::class)->except(['index']);
    Route::apiResource('resources', ResourceController::class)->except(['index']);
    Route::apiResource('community-groups', CommunityGroupController::class)->except(['index']);
    Route::apiResource('tv-stations', TVStationController::class)->except(['index']);
    Route::apiResource('radio-stations', RadioStationController::class)->except(['index']);
    Route::apiResource('locations', LocationController::class)->except(['index']);

    Route::get('contacts', [ContactController::class, 'index']);
    Route::get('questions', [QuestionController::class, 'index']);
    Route::post('questions/{question}/answer', [QuestionController::class, 'answer']);
    Route::post('contacts/{contact}/read', [ContactController::class, 'markRead']);
});

// Public endpoints
Route::post('contacts', [ContactController::class, 'store']);
Route::post('questions', [QuestionController::class, 'store']);
