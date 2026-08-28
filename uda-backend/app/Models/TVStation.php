<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TVStation extends Model
{
    protected $fillable = [
        'name', 'stream_url', 'description'
    ];
}
