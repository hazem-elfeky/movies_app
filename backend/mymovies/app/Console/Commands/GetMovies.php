<?php

namespace App\Console\Commands;

use App\Models\Movie;
use App\Models\Genre;
use App\Models\Actor;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Http;

class GetMovies extends Command
{
    protected $signature = 'app:get-movies';
    protected $description = 'Get Movies (Popular, Now Playing, Upcoming) From TMDB';

    public function handle()
    {
        $this->getPopularMovies();
        $this->getNowPlayingMovies();
        $this->getUpcomingMovies();  
    }

 
    private function getPopularMovies()
    {
        for ($i = 1; $i <= config('services.tmdb.max_pages'); $i++) {
            $response = Http::withoutVerifying()->get(
                config('services.tmdb.base_url') .
                '/movie/popular?api_key=' . config('services.tmdb.api_key') .
                '&page=' . $i . '&language=en-US'
            );

            foreach ($response->json()['results'] as $result) {
                $movie = Movie::updateOrCreate(
                    ['e_id' => $result['id']],
                    [
                        'title'        => $result['title'],
                        'description'  => $result['overview'],
                        'poster'       => $result['poster_path'],
                        'banner'       => $result['backdrop_path'],
                        'release_date' => $result['release_date'],
                        'vote'         => $result['vote_average'],
                        'vote_count'   => $result['vote_count'],
                        'type'         => 'popular', 
                    ]
                );

                $this->attachGenres($movie, $result);
                $this->attachActors($movie);
                $this->getImages($movie);
            }
        }

    }

  
    private function getNowPlayingMovies()
    {
        for ($i = 1; $i <= config('services.tmdb.max_pages'); $i++) {
            $response = Http::withoutVerifying()->get(
                config('services.tmdb.base_url') .
                '/movie/now_playing?api_key=' . config('services.tmdb.api_key') .
                '&page=' . $i . '&language=en-US'
            );

            foreach ($response->json()['results'] as $result) {
                $movie = Movie::updateOrCreate(
                    ['e_id' => $result['id']],
                    [
                        'title'        => $result['title'],
                        'description'  => $result['overview'],
                        'poster'       => $result['poster_path'],
                        'banner'       => $result['backdrop_path'],
                        'release_date' => $result['release_date'],
                        'vote'         => $result['vote_average'],
                        'vote_count'   => $result['vote_count'],
                        'type'         => 'now_playing', 
                    ]
                );

                $this->attachGenres($movie, $result);
                $this->attachActors($movie);
                $this->getImages($movie);
            }
        }

    }


    private function getUpcomingMovies()
    {
        for ($i = 1; $i <= config('services.tmdb.max_pages'); $i++) {
            $response = Http::withoutVerifying()->get(
                config('services.tmdb.base_url') .
                '/movie/upcoming?api_key=' . config('services.tmdb.api_key') .
                '&page=' . $i . '&language=en-US'
            );

            foreach ($response->json()['results'] as $result) {
                $movie = Movie::updateOrCreate(
                    ['e_id' => $result['id']],
                    [
                        'title'        => $result['title'],
                        'description'  => $result['overview'],
                        'poster'       => $result['poster_path'],
                        'banner'       => $result['backdrop_path'],
                        'release_date' => $result['release_date'],
                        'vote'         => $result['vote_average'],
                        'vote_count'   => $result['vote_count'],
                        'type'         => 'upcoming',
                    ]
                );

                $this->attachGenres($movie, $result);
                $this->attachActors($movie);
                $this->getImages($movie);
            }
        }

        $this->info('Upcoming Movies imported successfully 🎥');
    }


    private function attachGenres(Movie $movie, $result)
    {
        foreach ($result['genre_ids'] as $genreId) {
            $genre = Genre::where('e_id', $genreId)->first();
            if ($genre) {
                $movie->genres()->syncWithoutDetaching($genre->id);
            }
        }
    }


    private function attachActors(Movie $movie)
    {
        $response = Http::withoutVerifying()->get(
            config('services.tmdb.base_url') .
            '/movie/' . $movie->e_id .
            '/credits?api_key=' . config('services.tmdb.api_key') .
            '&language=en-US'
        );

        foreach ($response->json()['cast'] as $index => $cast) {
            if ($cast['known_for_department'] !== 'Acting') continue;
            if ($index === 12) break;

            $actor = Actor::updateOrCreate(
                ['e_id' => $cast['id']],
                [
                    'name'  => $cast['name'],
                    'image' => $cast['profile_path'],
                ]
            );

            $movie->actors()->syncWithoutDetaching($actor->id);
        }
    }

 
    private function getImages(Movie $movie)
    {
        $response = Http::withoutVerifying()->get(
            config('services.tmdb.base_url') .
            '/movie/' . $movie->e_id .
            '/images?api_key=' . config('services.tmdb.api_key')
        );

        $movie->images()->delete();

        foreach ($response->json()['backdrops'] as $index =>$im) {

            if($index == 8) break ;
            $movie->images()->create([
                'image' => $im['file_path'],
            ]);
        }
    }
}