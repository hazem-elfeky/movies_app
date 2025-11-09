<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class Movie extends Model
{
    protected $fillable = [
        'e_id',
        'title',
        'description',
        'poster',
        'banner',
        'type',
        'release_date',
        'vote',
        'vote_count'
    ];

    protected $appends = ['poster_path', 'banner_path'];


    public function getPosterPathAttribute()
    {
        return "https://image.tmdb.org/t/p/w500" . $this->poster;
    }

    public function getBannerPathAttribute()
    {
        return "https://image.tmdb.org/t/p/w500" . $this->banner;
    }

   
   public function scopeWhenType($query, $type)
{
    return $query->when(!empty($type), function ($q) use ($type) {
        return $q->where('type', $type);
    });
}

  
    public function scopeWhenSearch($query, $search)
    {
        return $query->when($search, function ($q) use ($search) {
            return $q->where('title', 'like', "%{$search}%");
        });
    }


public function scopeWhenGenreId($query, $genreId)
{
    return $query->when($genreId, function ($q) use ($genreId) {
        return $q->whereHas('genres', function ($qu) use ($genreId) {
            $qu->where('movie_genre.genre_id', $genreId);
        });
    });
}


    public function scopeWhenActorId($query, $actorId)
    {
        return $query->when($actorId, function ($q) use ($actorId) {
            return $q->whereHas('actors', function ($qu) use ($actorId) {
                return $qu->where('actors.id', $actorId);
            });
        });
    }


    public function scopeWhenFavoriteById($query, $favoriteById)
    {
        return $query->when($favoriteById, function ($q) use ($favoriteById) {
            return $q->whereHas('favoriteByUsers', function ($qu) use ($favoriteById) {
                return $qu->where('users.id', $favoriteById);
            });
        });
    }

   

   public function genres()
{
    return $this->belongsToMany(Genre::class, 'movie_genre', 'movie_id', 'genre_id');
}


    public function actors()
    {
        return $this->belongsToMany(Actor::class, 'movie_actor');
    }

    public function images()
    {
        return $this->hasMany(Image::class);
    }


    public function favoriteByUsers()
    {
        return $this->belongsToMany(User::class, 'user_favorite_movie', 'movie_id', 'user_id');
    }


 public function isFavorite()
{
    $user = Auth::user();
    if (!$user) return false;

    return $this->favoriteByUsers()->where('user_id', $user->id)->exists();
}

}