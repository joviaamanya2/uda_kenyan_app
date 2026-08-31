<?php

namespace Tests\Feature;

use App\Models\Donation;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class DonationTest extends TestCase
{
    use RefreshDatabase;

    public function test_fundraise_form_records_a_donation(): void
    {
        $this->postJson('/api/donations', [
            'name' => 'Jane Njeri',
            'email' => 'jane@example.com',
            'category' => 'Campaign Fund',
            'amount' => 100,
            'currency' => 'usd',
            'location' => 'Diaspora',
            'comment' => 'For the campaign',
        ])->assertCreated();

        $this->assertDatabaseHas('donations', [
            'name' => 'Jane Njeri',
            'amount' => 100,
            'currency' => 'USD',
            'status' => 'pledged',
        ]);
    }

    public function test_donation_requires_name_email_and_amount(): void
    {
        $this->postJson('/api/donations', ['name' => 'x'])
            ->assertStatus(422)
            ->assertJsonValidationErrors(['email', 'amount']);
    }

    public function test_admin_can_view_filter_and_update_donations(): void
    {
        $admin = User::factory()->create(['is_admin' => true]);

        $old = Donation::create(['name' => 'Old Donor', 'email' => 'o@x.com', 'amount' => 10]);
        $old->forceFill(['created_at' => now()->subDays(30)])->save();
        $new = Donation::create(['name' => 'New Donor', 'email' => 'n@x.com', 'amount' => 20]);

        $this->actingAs($admin)->get('/admin/donations')
            ->assertOk()->assertSee('Old Donor')->assertSee('New Donor');

        $this->actingAs($admin)->get('/admin/donations?filter=recent')
            ->assertOk()->assertSee('New Donor')->assertDontSee('Old Donor');

        $this->actingAs($admin)->patch("/admin/donations/{$new->id}/toggle-status");
        $this->assertEquals('received', $new->fresh()->status);
    }
}
