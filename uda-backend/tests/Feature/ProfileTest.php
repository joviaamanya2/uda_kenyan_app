<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Tests\TestCase;

class ProfileTest extends TestCase
{
    use RefreshDatabase;

    private function tokenFor(User $user): string
    {
        $token = 'tok_'.$user->id.'_test';
        $user->forceFill(['api_token' => hash('sha256', $token)])->save();

        return $token;
    }

    public function test_guests_cannot_read_the_profile(): void
    {
        $this->getJson('/api/me')->assertStatus(401);
    }

    public function test_user_can_read_their_profile(): void
    {
        $user = User::factory()->create(['name' => 'Jane']);
        $token = $this->tokenFor($user);

        $this->withHeader('Authorization', "Bearer {$token}")
            ->getJson('/api/me')
            ->assertOk()
            ->assertJsonPath('user.name', 'Jane')
            ->assertJsonMissingPath('user.password')
            ->assertJsonMissingPath('user.api_token');
    }

    public function test_user_can_update_details_and_avatar(): void
    {
        Storage::fake('public');
        $user = User::factory()->create();
        $token = $this->tokenFor($user);

        $this->withHeader('Authorization', "Bearer {$token}")
            ->post('/api/me', [
                'name' => 'Jane Njeri',
                'phone' => '0722000111',
                'county' => 'Nakuru',
                'bio' => 'UDA supporter',
                'avatar' => UploadedFile::fake()->image('me.jpg'),
            ])
            ->assertOk()
            ->assertJsonPath('user.county', 'Nakuru');

        $user->refresh();
        $this->assertSame('Jane Njeri', $user->name);
        $this->assertStringContainsString('/storage/uploads/avatars/', $user->avatar_path);
        $this->assertCount(1, Storage::disk('public')->allFiles('uploads/avatars'));
    }

    public function test_email_must_stay_unique(): void
    {
        User::factory()->create(['email' => 'taken@uda.local']);
        $user = User::factory()->create();
        $token = $this->tokenFor($user);

        $this->withHeader('Authorization', "Bearer {$token}")
            ->postJson('/api/me', ['email' => 'taken@uda.local'])
            ->assertStatus(422)
            ->assertJsonValidationErrors('email');
    }

    public function test_user_can_keep_their_own_email(): void
    {
        $user = User::factory()->create(['email' => 'mine@uda.local']);
        $token = $this->tokenFor($user);

        $this->withHeader('Authorization', "Bearer {$token}")
            ->postJson('/api/me', ['email' => 'mine@uda.local', 'phone' => '0700'])
            ->assertOk();
    }
}
