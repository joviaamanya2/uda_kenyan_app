<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Leader extends Model
{
    protected $fillable = [
        'name', 'category', 'section', 'position', 'county', 'constituency',
        'bio', 'office', 'email', 'phone', 'term_label', 'photo_path',
        'is_featured', 'sort_order',
    ];

    protected $casts = [
        'is_featured' => 'boolean',
        'sort_order' => 'integer',
    ];
}
