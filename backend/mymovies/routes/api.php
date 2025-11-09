<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\GenreController;
use App\Http\Controllers\Api\MovieController;

Route::post('/login', [AuthController::class, 'login']);

Route::post('/register', [AuthController::class, 'register']);

Route::middleware('auth:sanctum')->get('/user', action: [AuthController::class, 'user']);

Route::get('/genres', action: [GenreController::class, 'index']);

 Route::get('/movies/favorites', [MovieController::class, 'favorites'])
  ->middleware('auth:sanctum');

Route::get('/movies', action: [MovieController::class, 'index']);

Route::get('/movies/{movie}', [MovieController::class, 'show']); 

Route::get('/movies/toggle_movie/{movie_id}', [MovieController::class, 'toggleFavorite'])
   ->middleware('auth:sanctum');


Route::get('/movies/{movie}/is_favorite', [MovieController::class, 'isFavorite'])
    ->middleware('auth:sanctum');

 

Route::get('/movies/{movie}/images', [MovieController::class, 'images']);

Route::get('/movies/{movie}/actors', action: [MovieController::class, 'actors']);