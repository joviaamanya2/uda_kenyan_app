<?php

namespace Database\Seeders;

use App\Models\CommunityGroup;
use Illuminate\Database\Seeder;

class CommunityGroupSeeder extends Seeder
{
    public function run(): void
    {
        $groups = [
            ['UDA Party Members', 'Official channel for registered UDA members.', 'Nationwide'],
            ['UDA Youth League', 'Young UDA supporters organising and mobilising.', 'Nationwide'],
            ['UDA Women Congress', 'Women championing the UDA agenda.', 'Nationwide'],
            ['UDA Bloggers & Digital Team', 'Content creators amplifying the party online.', 'Nationwide'],
            ['UDA Persons with Disabilities Caucus', 'Advocacy and inclusion for PWDs.', 'Nationwide'],
            ['UDA Diaspora Network', 'Kenyans abroad supporting UDA.', 'Diaspora'],
        ];

        // firstOrCreate: never overwrite a WhatsApp link an admin has already set.
        foreach ($groups as [$name, $description, $location]) {
            CommunityGroup::firstOrCreate(
                ['name' => $name],
                ['description' => $description, 'location' => $location],
            );
        }
    }
}
