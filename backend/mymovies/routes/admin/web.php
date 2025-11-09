<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\UserController;
use App\Http\Controllers\Admin\MovieController;

/*
|--------------------------------------------------------------------------
| Admin Web Routes
|--------------------------------------------------------------------------
|
| هنا بنحط كل الراوتس الخاصة بالـ Admin panel.
| غالبًا هنحط prefix و middleware للـ auth والـ admin guard.
|
*/

Route::prefix('admin')->name('admin.')->middleware(['auth', 'is_admin'])->group(function () {

    // Dashboard
    Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');

    // Users Management
    Route::resource('users', UserController::class);

    // Movies Management
    Route::resource('movies', MovieController::class);

    // مثال لراوت إضافية لو محتاجين
    Route::get('/reports', [DashboardController::class, 'reports'])->name('reports');
});
