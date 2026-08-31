<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Donation extends Model
{
    protected $fillable = [
        'name', 'email', 'category', 'amount', 'currency', 'location', 'comment', 'status',
    ];

    protected $casts = [
        'amount' => 'decimal:2',
    ];
}
