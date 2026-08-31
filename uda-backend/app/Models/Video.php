<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Video extends Model
{
    protected $fillable = [
        'title', 'description', 'url', 'thumbnail_path', 'category', 'duration', 'published_at',
    ];

    protected $casts = [
        'published_at' => 'datetime',
    ];
}
