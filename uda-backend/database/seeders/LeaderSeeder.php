<?php

namespace Database\Seeders;

use App\Models\Leader;
use Illuminate\Database\Seeder;

class LeaderSeeder extends Seeder
{
    public function run(): void
    {
        // Top national leadership: shown on the home screen's "UDA Elects"
        // carousel and the Executive Committee screen.
        $executive = [
            [
                'name' => 'William Ruto',
                'position' => 'President',
                'county' => 'KENYA',
                'constituency' => 'National',
                'bio' => 'H.E Dr. William Ruto is the President of Kenya and the Party Leader of UDA. He is committed to transforming Kenya through the Bottom-Up Economic Transformation Agenda.',
                'office' => 'State House, Nairobi',
                'email' => 'william.ruto@uda.go.ke',
                'phone' => '+254 700 000 000',
                'term_label' => 'Active since 2022',
                'photo_path' => 'assets/images/William Ruto.PNG',
                'is_featured' => true,
                'sort_order' => 0,
            ],
            [
                'name' => 'H.E Pro.Kithure Kindiki',
                'position' => 'Deputy President',
                'county' => 'KENYA',
                'constituency' => 'National',
                'bio' => 'H.E. Prof. Kithure Kindiki is the Deputy President of Kenya. He is a dedicated leader focused on economic empowerment and grassroots development.',
                'office' => 'State House, Nairobi',
                'email' => 'kithure.kindiki@uda.go.ke',
                'phone' => '+254 700 000 003',
                'term_label' => 'Active since 2022',
                'photo_path' => 'assets/images/H.E Prof. Kithure Kindiki.PNG',
                'is_featured' => false,
                'sort_order' => 1,
            ],
            [
                'name' => 'H.E Issa Timamy',
                'position' => 'Governor, Lamu County',
                'county' => 'KENYA',
                'constituency' => 'National',
                'bio' => 'H.E. Issa Timamy is the Governor of Lamu County and a member of the UDA Executive Committee. He is committed to the development and welfare of his constituents.',
                'office' => 'Nyeri, Kenya',
                'email' => 'issa.timamy@uda.go.ke',
                'phone' => '+254 700 000 005',
                'term_label' => 'Active since 2023',
                'photo_path' => 'assets/images/H.E Issa Timamy.png',
                'is_featured' => false,
                'sort_order' => 2,
            ],
            [
                'name' => 'H.E Cecily Mbarire',
                'position' => 'CHAIRPERSON, Governor, Embu County',
                'county' => 'KENYA',
                'constituency' => 'National',
                'bio' => 'H.E Cecily Mbarire is the Governor of Embu County and the Chairperson of UDA. She is dedicated to the development and welfare of her constituents.',
                'office' => 'Embu County Office',
                'email' => 'cecily.mbarire@uda.go.ke',
                'phone' => '+254 700 000 001',
                'term_label' => 'Active since 2023',
                'photo_path' => 'assets/images/H.E Cecily Mbarire.PNG',
                'is_featured' => false,
                'sort_order' => 3,
            ],
            [
                'name' => 'Mr. Kelvin Lunani',
                'position' => 'DEPUTY CHAIRPERSON',
                'county' => 'KENYA',
                'constituency' => 'National',
                'bio' => 'Mr. Kelvin Lunani is the Deputy Chairperson of UDA. He is committed to the development and welfare of his constituents.',
                'office' => 'Nairobi, Kenya',
                'email' => 'kelvin.lunani@uda.go.ke',
                'phone' => '+254 700 000 002',
                'term_label' => 'Active since 2022',
                'photo_path' => 'assets/images/Mr. Kelvin Lunani.PNG',
                'is_featured' => false,
                'sort_order' => 4,
            ],
            [
                'name' => 'Hon. Sen. Hassan Omar',
                'position' => 'SECRETARY GENERAL,MP EALA',
                'county' => 'KENYA',
                'constituency' => 'National',
                'bio' => 'Hon. Hassan Omar is the Secretary General of UDA. He is committed to the development and welfare of his constituents.',
                'office' => 'Mombasa, Kenya',
                'email' => 'hassan.omar@uda.go.ke',
                'phone' => '+254 700 000 004',
                'term_label' => 'Active since 2021',
                'photo_path' => 'assets/images/Hon. Sen. Hassan Omar.PNG',
                'is_featured' => false,
                'sort_order' => 5,
            ],
            [
                'name' => 'Hon. Omboko Milemba',
                'position' => 'DEPUTY SECRETARY GENERAL,MP Emuhaya Constituency',
                'county' => 'KENYA',
                'constituency' => 'National',
                'bio' => 'Hon. Omboko Milemba is the Deputy Secretary General of UDA. He is committed to the development and welfare of his constituents.',
                'office' => 'Nairobi, Kenya',
                'email' => 'omboko.milemba@uda.go.ke',
                'phone' => '+254 700 000 007',
                'term_label' => 'Active since 2022',
                'photo_path' => 'assets/images/Omboko Milemba.PNG',
                'is_featured' => false,
                'sort_order' => 6,
            ],
            [
                'name' => 'Hon. Japheth Nyakundi',
                'position' => 'NATIONAL TREASURER,MP Kitutu Chache North Constituency',
                'county' => 'KENYA',
                'constituency' => 'National',
                'bio' => 'Hon. Japheth Nyakundi is the National Treasurer of UDA. He is committed to the development and welfare of his constituents.',
                'office' => 'Nairobi, Kenya',
                'email' => 'japheth.nyakundi@uda.go.ke',
                'phone' => '+254 700 000 008',
                'term_label' => 'Active since 2021',
                'photo_path' => 'assets/images/Hon. Japheth Nyakundi.PNG',
                'is_featured' => false,
                'sort_order' => 7,
            ],
            [
                'name' => 'Mr. Nicodemus Bore',
                'position' => 'EXECUTIVE DIRECTOR',
                'county' => 'KENYA',
                'constituency' => 'National',
                'bio' => 'Mr. Nicodemus Bore is the Executive Director of UDA. He is committed to the development and welfare of his constituents.',
                'office' => 'Nairobi, Kenya',
                'email' => 'nicodemus.bore@uda.go.ke',
                'phone' => '+254 700 000 006',
                'term_label' => 'Active since 2023',
                'photo_path' => 'assets/images/Mr. Nicodemus Bore.PNG',
                'is_featured' => false,
                'sort_order' => 8,
            ],
        ];

        foreach ($executive as $index => $leader) {
            Leader::updateOrCreate(
                ['name' => $leader['name']],
                $leader + ['category' => 'executive', 'sort_order' => $index],
            );
        }

        // Sectioned party leadership roster shown on the UDA Leaders screen,
        // grouped client-side by 'section'.
        $partyLeadership = [
            'National Chairperson' => [
                ['name' => 'H.E Dr. William Ruto', 'position' => 'Chairman - UDA'],
            ],
            'Secretary General' => [
                ['name' => 'Hon. Cleophas Malala', 'position' => 'Secretary General - UDA'],
                ['name' => 'Hon. Mary Kiguru', 'position' => 'Deputy Secretary General'],
            ],
            'National Treasurer' => [
                ['name' => 'Hon. Esther Mwangi', 'position' => 'National Treasurer'],
                ['name' => 'Hon. Julius Kipyegon', 'position' => 'Deputy National Treasurer'],
            ],
            'Electoral Commission' => [
                ['name' => 'Hon. Githinji Njoroge', 'position' => 'Chairperson - Electoral Commission'],
                ['name' => 'Hon. Grace Akinyi', 'position' => 'Vice Chairperson - Electoral Commission'],
                ['name' => 'Hon. John Mwangi', 'position' => 'Commissioner - Electoral Commission'],
            ],
            'National Secretariat Directors' => [
                ['name' => 'Hon. David Were', 'position' => 'Director - Administration'],
                ['name' => 'Hon. Caroline Omondi', 'position' => 'Director - Finance'],
                ['name' => 'Hon. Mohammed Hassan', 'position' => 'Director - Communications'],
                ['name' => 'Hon. Sarah Lokenyo', 'position' => 'Director - Research & Policy'],
            ],
        ];

        $sortOrder = 0;
        foreach ($partyLeadership as $section => $members) {
            foreach ($members as $member) {
                Leader::updateOrCreate(
                    ['name' => $member['name'], 'section' => $section],
                    $member + [
                        'category' => 'party_leadership',
                        'section' => $section,
                        'sort_order' => $sortOrder++,
                    ],
                );
            }
        }
    }
}
