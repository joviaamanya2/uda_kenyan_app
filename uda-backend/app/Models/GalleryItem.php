<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class GalleryItem extends Model
{
    protected $fillable = [
        'title', 'type', 'path', 'caption'
    ];
    // type could be 'image'|'video' etc.
}
