<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Resource extends Model
{
    protected $fillable = [
        'title', 'type', 'file_path', 'description', 'published_at'
    ];
    protected $casts = [
        'published_at' => 'datetime',
    ];
}
