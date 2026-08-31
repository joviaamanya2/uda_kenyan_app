<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        if (! User::where('email', 'test@example.com')->exists()) {
            User::factory()->create([
                'name' => 'Test User',
                'email' => 'test@example.com',
            ]);
        }

        // Default admin dashboard login. Change the password after first sign-in
        // (or run `php artisan admin:create`).
        User::updateOrCreate(
            ['email' => 'admin@uda.ke'],
            [
                'name' => 'UDA Admin',
                'password' => Hash::make('password'),
                'is_admin' => true,
            ],
        );

        $this->call([
            LeaderSeeder::class,
            NewsSeeder::class,
            EventSeeder::class,
            LocationSeeder::class,
            SettingSeeder::class,
            VideoSeeder::class,
            CommunityGroupSeeder::class,
            MediaStationSeeder::class,
            PostSeeder::class,
        ]);
    }
}
