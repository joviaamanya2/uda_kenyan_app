<?php

namespace App\Console\Commands;

use App\Models\User;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Hash;

class CreateAdminUser extends Command
{
    protected $signature = 'admin:create
        {--name= : Full name}
        {--email= : Login email}
        {--password= : Login password}';

    protected $description = 'Create (or promote) an admin dashboard user';

    public function handle(): int
    {
        $name = $this->option('name') ?: $this->ask('Name', 'UDA Admin');
        $email = $this->option('email') ?: $this->ask('Email', 'admin@uda.ke');
        $password = $this->option('password') ?: $this->secret('Password (min 8 chars)');

        if (! $password || strlen($password) < 8) {
            $this->error('Password must be at least 8 characters.');

            return self::FAILURE;
        }

        $user = User::updateOrCreate(
            ['email' => $email],
            ['name' => $name, 'password' => Hash::make($password), 'is_admin' => true],
        );

        $this->info("Admin ready: {$user->email}");

        return self::SUCCESS;
    }
}
