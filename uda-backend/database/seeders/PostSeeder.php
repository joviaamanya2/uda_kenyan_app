<?php

namespace Database\Seeders;

use App\Models\Post;
use App\Models\User;
use Illuminate\Database\Seeder;

class PostSeeder extends Seeder
{
    public function run(): void
    {
        $author = User::where('email', 'admin@uda.ke')->first()
            ?? User::first();

        if (! $author) {
            return;
        }

        $posts = [
            'Karibu to the UDA Community! Share your ideas, ask questions and connect with fellow members here. Kazi ni Kazi.',
            'Grassroots mobilisation is picking up across the counties. Tag your ward team and let\'s keep the momentum going.',
            'Reminder: verify that your membership details are up to date in the app profile section so you can take part in party activities.',
        ];

        foreach ($posts as $content) {
            Post::firstOrCreate(
                ['content' => $content],
                ['user_id' => $author->id],
            );
        }
    }
}
