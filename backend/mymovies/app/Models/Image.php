<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Image extends Model
{
    use HasFactory;

    protected $fillable = [
        'movie_id',
        'image',
    ];

    protected $appends = ['image_path'];

    public function movie()
    {
        return $this->belongsTo(Movie::class);
    }

    public function getImagePathAttribute()
    {
        if ($this->image) {
            return "https://image.tmdb.org/t/p/w500" . $this->image;
        }
        return null;
    }
}