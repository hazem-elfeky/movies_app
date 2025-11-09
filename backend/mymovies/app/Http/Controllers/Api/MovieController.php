<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Movie;
use App\Http\Resources\MovieResource;
use App\Http\Resources\ImageResource;
use App\Http\Resources\ActorResource;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Auth;

class MovieController extends Controller
{
    public function index(Request $request)
    {
        $movies = Movie::whenType($request->type)
            ->whenSearch($request->search)
            ->whenGenreId($request->genre_id)
            ->whenActorId($request->actor_id)
            ->whenFavoriteById($request->favorite_by_id) 
            ->with('genres')
            ->paginate(10);

        $data = MovieResource::collection($movies)
            ->response()
            ->getData(true);

        return Response::api($data);
    }

    public function show(Movie $movie)
    {
        $movie->load('genres'); 
        $data = (new MovieResource($movie))
            ->response()
            ->getData(true);

        return Response::api($data);
    }

    public function toggleFavorite($movie_id)
    {
        $user = Auth::user();

        if (!$user) {
            return Response::api([], 1, 'User not authenticated');
        }

        $user->favoriteMovies()->toggle($movie_id);

        return Response::api(null, 0, 'Movie toggled successfully');
    }

public function favorites()
{
    $user = Auth::user();
    if (!$user) {
        return Response::api([], 1, 'User not authenticated');
    }

    $movies = $user->favoriteMovies()->with('genres')->get();

    $data = MovieResource::collection($movies)
        ->response()
        ->getData(true);

    return Response::api($data);
}




    public function images(Movie $movie)
    {
        return Response::api(
            ImageResource::collection($movie->images)
        );
    }

    public function actors(Movie $movie)
    {
        return Response::api(
            ActorResource::collection($movie->actors)
        );
    }

    public function isFavorite(Movie $movie)
    {
        $data['is_favorite'] = $movie->isFavorite();

        return Response::api($data);
    }
}