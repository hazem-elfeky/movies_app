<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Genre;
use App\Http\Resources\GenreResource;
use Illuminate\Support\Facades\Response; 

class GenreController extends Controller
{
    public function index()
    {
        $genres = Genre::all();

        return Response::api(
            GenreResource::collection($genres)
        );
    }
}