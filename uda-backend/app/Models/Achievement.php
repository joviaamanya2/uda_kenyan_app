<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Achievement extends Model
{
    protected $fillable = [
        'title', 'description', 'image_path', 'date'
    ];
    protected $casts = [
        'date' => 'date',
    ];
}
