<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RadioStation extends Model
{
    protected $fillable = [
        'name', 'stream_url', 'frequency', 'description'
    ];
}
