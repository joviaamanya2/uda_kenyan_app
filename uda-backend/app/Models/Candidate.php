<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Candidate extends Model
{
    protected $fillable = [
        'name', 'position', 'constituency', 'party', 'bio', 'photo_path', 'is_elected'
    ];
    protected $casts = [
        'is_elected' => 'boolean',
    ];
}
