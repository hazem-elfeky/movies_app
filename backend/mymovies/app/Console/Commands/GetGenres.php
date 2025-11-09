<?php

namespace App\Console\Commands;

use App\Models\Genre;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Http;

class GetGenres extends Command
{
    protected $signature = 'app:get-genres';
    protected $description = 'Get All genres From TMDB ';

    public function handle()
    {
        $response = Http::withoutVerifying()->get(
            config('services.tmdb.base_url') . '/genre/movie/list?api_key=' . config('services.tmdb.api_key')
        );

        foreach ($response->json()['genres'] as $genre){
            Genre::updateOrCreate(
                ['e_id' => $genre['id']],
                ['name' => $genre['name']]
            );
        }

        $this->info('Genres imported successfully 🚀');
    }
}