<?php

use App\Http\Controllers\Admin\AuthController;
use App\Http\Controllers\Admin\ContactMessageController;
use App\Http\Controllers\Admin\CrudController;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\DonationController;
use App\Http\Controllers\Admin\MemberController;
use App\Http\Controllers\Admin\PostController;
use App\Http\Controllers\Admin\QuestionController;
use App\Http\Controllers\Admin\SettingController;
use App\Http\Controllers\Admin\UserController;
use Illuminate\Support\Facades\Route;

Route::get('/', fn () => redirect()->route('admin.login'));

Route::prefix('admin')->name('admin.')->group(function () {
    Route::get('login', [AuthController::class, 'showLogin'])->name('login');
    Route::post('login', [AuthController::class, 'login'])->name('login.attempt');
    Route::post('logout', [AuthController::class, 'logout'])->name('logout');

    Route::middleware('admin')->group(function () {
        Route::get('/', [DashboardController::class, 'index'])->name('dashboard');

        // Submitted data (inbox)
        Route::get('messages', [ContactMessageController::class, 'index'])->name('messages.index');
        Route::patch('messages/{message}/toggle-read', [ContactMessageController::class, 'toggleRead'])->name('messages.toggleRead');
        Route::delete('messages/{message}', [ContactMessageController::class, 'destroy'])->name('messages.destroy');

        Route::get('questions', [QuestionController::class, 'index'])->name('questions.index');
        Route::patch('questions/{question}/answer', [QuestionController::class, 'answer'])->name('questions.answer');
        Route::delete('questions/{question}', [QuestionController::class, 'destroy'])->name('questions.destroy');

        Route::get('users', [UserController::class, 'index'])->name('users.index');
        Route::patch('users/{user}/toggle-admin', [UserController::class, 'toggleAdmin'])->name('users.toggleAdmin');
        Route::delete('users/{user}', [UserController::class, 'destroy'])->name('users.destroy');

        Route::get('posts', [PostController::class, 'index'])->name('posts.index');
        Route::get('posts/{post}', [PostController::class, 'show'])->name('posts.show');
        Route::delete('posts/{post}', [PostController::class, 'destroy'])->name('posts.destroy');
        Route::delete('comments/{comment}', [PostController::class, 'destroyComment'])->name('comments.destroy');

        Route::get('members', [MemberController::class, 'index'])->name('members.index');
        Route::get('members/{member}', [MemberController::class, 'show'])->name('members.show');
        Route::delete('members/{member}', [MemberController::class, 'destroy'])->name('members.destroy');

        Route::get('settings', [SettingController::class, 'edit'])->name('settings.edit');
        Route::put('settings', [SettingController::class, 'update'])->name('settings.update');

        Route::get('donations', [DonationController::class, 'index'])->name('donations.index');
        Route::get('donations/{donation}', [DonationController::class, 'show'])->name('donations.show');
        Route::patch('donations/{donation}/toggle-status', [DonationController::class, 'toggleStatus'])->name('donations.toggleStatus');
        Route::delete('donations/{donation}', [DonationController::class, 'destroy'])->name('donations.destroy');

        // Generic content CRUD (driven by App\Admin\ResourceRegistry)
        Route::get('c/{resource}', [CrudController::class, 'index'])->name('resource.index');
        Route::get('c/{resource}/create', [CrudController::class, 'create'])->name('resource.create');
        Route::post('c/{resource}', [CrudController::class, 'store'])->name('resource.store');
        Route::get('c/{resource}/{id}/edit', [CrudController::class, 'edit'])->name('resource.edit');
        Route::put('c/{resource}/{id}', [CrudController::class, 'update'])->name('resource.update');
        Route::delete('c/{resource}/{id}', [CrudController::class, 'destroy'])->name('resource.destroy');
    });
});
