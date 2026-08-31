<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CommunityGroup extends Model
{
    protected $fillable = [
        'name', 'description', 'location', 'contact_info', 'whatsapp',
    ];
}
