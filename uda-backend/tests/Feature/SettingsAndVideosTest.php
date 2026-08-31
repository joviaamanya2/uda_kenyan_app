<?php

namespace Tests\Feature;

use App\Models\Setting;
use App\Models\User;
use App\Models\Video;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class SettingsAndVideosTest extends TestCase
{
    use RefreshDatabase;

    public function test_settings_api_returns_key_value_map(): void
    {
        Setting::put('contact_phone', '020 2020405');
        Setting::put('about_vision', 'A vision');

        $this->getJson('/api/settings')
            ->assertOk()
            ->assertJson([
                'contact_phone' => '020 2020405',
                'about_vision' => 'A vision',
            ]);
    }

    public function test_admin_can_edit_settings(): void
    {
        $admin = User::factory()->create(['is_admin' => true]);

        $this->actingAs($admin)->get('/admin/settings')->assertOk()->assertSee('Contact information');

        $this->actingAs($admin)->put('/admin/settings', [
            'contact_phone' => '0700 000 000',
            'about_vision' => 'Updated vision',
        ])->assertRedirect(route('admin.settings.edit'));

        $this->assertSame('0700 000 000', Setting::get('contact_phone'));
        $this->assertSame('Updated vision', Setting::get('about_vision'));
    }

    public function test_videos_api_is_public_and_ordered(): void
    {
        Video::create(['title' => 'Old', 'url' => 'https://x.test/1', 'published_at' => now()->subDays(5)]);
        Video::create(['title' => 'New', 'url' => 'https://x.test/2', 'published_at' => now()]);

        $data = $this->getJson('/api/videos')->assertOk()->json();
        $this->assertSame('New', $data[0]['title']);
    }

    public function test_video_writes_require_auth_and_a_url(): void
    {
        $this->postJson('/api/videos', ['title' => 'x'])->assertStatus(401);

        $admin = User::factory()->create(['is_admin' => true]);
        $token = 'vtok_'.$admin->id;
        $admin->forceFill(['api_token' => hash('sha256', $token)])->save();

        $this->withHeader('Authorization', "Bearer {$token}")
            ->postJson('/api/videos', ['title' => 'Speech'])
            ->assertStatus(422)
            ->assertJsonValidationErrors('url');
    }

    public function test_gallery_is_no_longer_a_dashboard_resource(): void
    {
        $admin = User::factory()->create(['is_admin' => true]);
        $this->actingAs($admin)->get('/admin/c/gallery')->assertNotFound();
        $this->actingAs($admin)->get('/admin/c/videos')->assertOk();
    }
}
