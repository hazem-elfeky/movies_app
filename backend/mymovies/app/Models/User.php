<?php


namespace App\Models;

use App\Models\Movie;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Support\Facades\Storage;


class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $fillable = [
        'name',
        'email',
        'password',
        'image',
        'type'
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }


       public function favoriteMovies(): BelongsToMany
    {
        return $this->belongsToMany(Movie::class, 'user_favorite_movie', 'user_id', 'movie_id');
    }


    public function scopeWhereRoleId($query, $roleId)
    {
        return $query->whereHas('roles', function ($qUserRoleId) use ($roleId) {
            $qUserRoleId->where('id', $roleId);
        });
    }


    public function getNameAttribute($value)
    {
        return ucfirst($value);
    }

   
    public function getImagePathAttribute()
    {
        if ($this->image) {
            return Storage::url('uploads/' . $this->image);
        }

        return asset('admin/assets/images/default.png');
    }

  
    public function hasImage()
    {
        return $this->image != null;
    }
}