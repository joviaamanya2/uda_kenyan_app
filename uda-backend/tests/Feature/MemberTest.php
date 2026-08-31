<?php

namespace Tests\Feature;

use App\Models\Member;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Tests\TestCase;

class MemberTest extends TestCase
{
    use RefreshDatabase;

    public function test_join_uda_form_creates_a_member_with_id_photos(): void
    {
        Storage::fake('public');

        $response = $this->postJson('/api/members', [
            'surname' => 'Kamau',
            'other_name' => 'John',
            'phone' => '0712345678',
            'gender' => 'Male',
            'district' => 'Kiambu',
            'was_in_uda' => '1',
            'uda_from' => '2021',
            'id_front' => UploadedFile::fake()->image('front.jpg'),
            'id_back' => UploadedFile::fake()->image('back.jpg'),
        ]);

        $response->assertCreated();
        $this->assertDatabaseHas('members', [
            'surname' => 'Kamau',
            'other_name' => 'John',
            'was_in_uda' => true,
        ]);

        $member = Member::first();
        $this->assertStringContainsString('/storage/uploads/members/', $member->id_front_path);
        $this->assertStringContainsString('/storage/uploads/members/', $member->id_back_path);
        $this->assertCount(2, Storage::disk('public')->allFiles('uploads/members'));
    }

    public function test_membership_requires_name_and_phone(): void
    {
        $this->postJson('/api/members', ['other_name' => 'John'])
            ->assertStatus(422)
            ->assertJsonValidationErrors(['surname', 'phone']);
    }

    public function test_admin_members_screen_filters_recently_joined(): void
    {
        $admin = User::factory()->create(['is_admin' => true]);

        $old = Member::create(['surname' => 'Old', 'other_name' => 'Member', 'phone' => '1']);
        $old->forceFill(['created_at' => now()->subDays(30)])->save();
        Member::create(['surname' => 'New', 'other_name' => 'Member', 'phone' => '2']);

        $this->actingAs($admin)->get('/admin/members')
            ->assertOk()->assertSee('Old')->assertSee('New');

        $this->actingAs($admin)->get('/admin/members?filter=recent')
            ->assertOk()->assertSee('New')->assertDontSee('>Old<', false);
    }
}
