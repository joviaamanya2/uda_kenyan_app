<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Member extends Model
{
    protected $fillable = [
        'surname', 'other_name', 'phone', 'national_id_number', 'gender',
        'district', 'village', 'sub_county', 'parish',
        'id_front_path', 'id_back_path',
        'was_in_uda', 'uda_from', 'uda_to',
        'was_in_other_party', 'previous_party',
    ];

    protected $casts = [
        'was_in_uda' => 'boolean',
        'was_in_other_party' => 'boolean',
    ];

    public function getFullNameAttribute(): string
    {
        return trim("{$this->other_name} {$this->surname}");
    }
}
