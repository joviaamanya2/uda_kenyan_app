<?php

namespace Tests\Feature;

use App\Models\Event;
use App\Models\Leader;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Tests\TestCase;

class AdminDashboardTest extends TestCase
{
    use RefreshDatabase;

    private function admin(): User
    {
        return User::factory()->create(['is_admin' => true]);
    }

    public function test_guests_are_redirected_to_login(): void
    {
        $this->get('/admin')->assertRedirect(route('admin.login'));
    }

    public function test_non_admins_cannot_access_dashboard(): void
    {
        $user = User::factory()->create(['is_admin' => false]);

        $this->actingAs($user)->get('/admin')->assertRedirect(route('admin.login'));
    }

    public function test_admin_can_view_dashboard_and_resource_index(): void
    {
        $this->actingAs($this->admin())->get('/admin')->assertOk();
        $this->actingAs($this->admin())->get('/admin/c/events')->assertOk();
    }

    public function test_unknown_resource_returns_404(): void
    {
        $this->actingAs($this->admin())->get('/admin/c/not-a-resource')->assertNotFound();
    }

    public function test_admin_can_create_and_delete_a_record(): void
    {
        $admin = $this->admin();

        $this->actingAs($admin)->post('/admin/c/events', [
            'title' => 'Rally',
            'category' => 'Rally',
            'start_time' => '2026-09-10T10:00',
        ])->assertRedirect(route('admin.resource.index', 'events'));

        $this->assertDatabaseHas('events', ['title' => 'Rally']);

        $event = Event::first();

        $this->actingAs($admin)->delete("/admin/c/events/{$event->id}")
            ->assertRedirect(route('admin.resource.index', 'events'));

        $this->assertDatabaseMissing('events', ['id' => $event->id]);
    }

    public function test_validation_errors_are_returned(): void
    {
        $this->actingAs($this->admin())
            ->post('/admin/c/events', ['start_time' => '2026-09-10T10:00'])
            ->assertSessionHasErrors('title');
    }

    public function test_image_upload_is_stored_and_saved_as_url(): void
    {
        Storage::fake('public');

        $this->actingAs($this->admin())->post('/admin/c/leaders', [
            'name' => 'Jane Leader',
            'category' => 'executive',
            'photo_path' => UploadedFile::fake()->image('jane.jpg'),
        ])->assertRedirect();

        $path = Storage::disk('public')->allFiles('uploads/leaders')[0] ?? null;
        $this->assertNotNull($path);
        $this->assertStringContainsString('/storage/'.$path, Leader::first()->photo_path);
    }
}
