<?php

namespace Database\Seeders;

use App\Models\Video;
use Illuminate\Database\Seeder;

class VideoSeeder extends Seeder
{
    public function run(): void
    {
        $videos = [
            [
                'title' => 'Address by H.E. President Ruto at UDA National Delegates Convention',
                'description' => 'President William Ruto addresses UDA delegates at KICC, Nairobi.',
                'url' => 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
                'category' => 'Speeches',
                'duration' => '45:22',
                'published_at' => '2026-06-09',
            ],
            [
                'title' => 'State of the Nation Address by H.E. President William Ruto',
                'description' => 'President Ruto delivers the State of the Nation Address at Parliament.',
                'url' => 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
                'category' => 'Speeches',
                'duration' => '1:12:45',
                'published_at' => '2026-06-04',
            ],
            [
                'title' => 'UDA Party Leaders Meet on Economic Transformation Agenda',
                'description' => 'UDA leaders hold a strategic meeting on the Bottom-Up Economic Agenda.',
                'url' => 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
                'category' => 'Highlights',
                'duration' => '28:15',
                'published_at' => '2026-05-22',
            ],
        ];

        foreach ($videos as $video) {
            Video::updateOrCreate(['title' => $video['title']], $video);
        }
    }
}
