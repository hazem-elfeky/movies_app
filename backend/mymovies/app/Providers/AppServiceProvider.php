<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Response;

class AppServiceProvider extends ServiceProvider
{
  
    public function register(): void
    {
    }

    
    public function boot(): void
    {
        Schema::defaultStringLength(191);

        Response::macro('api', function ($data = null, $error = 0, $message = '') {
            return response()->json([
                'data' => $data,
                'error' => $error,
                'message' => $message,
            ]);
        });
    }
}