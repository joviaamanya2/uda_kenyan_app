<?php

namespace Tests\Feature;

use App\Models\Post;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Tests\TestCase;

class CommunityFeedTest extends TestCase
{
    use RefreshDatabase;

    private function auth(User $user): array
    {
        $token = 'ptok_'.$user->id;
        $user->forceFill(['api_token' => hash('sha256', $token)])->save();

        return [
            'Authorization' => "Bearer {$token}",
            'Accept' => 'application/json',
        ];
    }

    public function test_feed_is_public(): void
    {
        $u = User::factory()->create(['name' => 'Jane']);
        Post::create(['user_id' => $u->id, 'content' => 'Hello UDA']);

        $this->getJson('/api/posts')
            ->assertOk()
            ->assertJsonPath('data.0.content', 'Hello UDA')
            ->assertJsonPath('data.0.author.name', 'Jane')
            ->assertJsonPath('data.0.liked', false);
    }

    public function test_posting_requires_auth_and_content(): void
    {
        $this->postJson('/api/posts', ['content' => 'hi'])->assertStatus(401);

        $u = User::factory()->create();
        $this->withHeaders($this->auth($u))
            ->postJson('/api/posts', [])
            ->assertStatus(422)
            ->assertJsonValidationErrors('content');

        $this->withHeaders($this->auth($u))
            ->postJson('/api/posts', ['content' => 'Kazi ni Kazi'])
            ->assertCreated()
            ->assertJsonPath('content', 'Kazi ni Kazi')
            ->assertJsonPath('is_mine', true);
    }

    public function test_can_post_a_photo(): void
    {
        Storage::fake('public');
        $u = User::factory()->create();

        $this->withHeaders($this->auth($u))->post('/api/posts', [
            'content' => 'Look at this',
            'media' => UploadedFile::fake()->image('rally.jpg'),
        ])->assertCreated()->assertJsonPath('media_type', 'image');

        $post = Post::first();
        $this->assertStringContainsString('/storage/uploads/posts/', $post->image_path);
        $this->assertCount(1, Storage::disk('public')->allFiles('uploads/posts'));
    }

    public function test_can_post_a_video(): void
    {
        Storage::fake('public');
        $u = User::factory()->create();

        $video = UploadedFile::fake()->create('clip.mp4', 2048, 'video/mp4');

        $this->withHeaders($this->auth($u))->post('/api/posts', [
            'content' => '',
            'media' => $video,
        ])->assertCreated()->assertJsonPath('media_type', 'video');
    }

    public function test_non_media_files_are_rejected(): void
    {
        $u = User::factory()->create();
        $this->withHeaders($this->auth($u))->post('/api/posts', [
            'content' => 'hi',
            'media' => UploadedFile::fake()->create('notes.txt', 10, 'text/plain'),
        ])->assertStatus(422)->assertJsonValidationErrors('media');
    }

    public function test_like_toggles_and_is_reflected_per_user(): void
    {
        $author = User::factory()->create();
        $liker = User::factory()->create();
        $post = Post::create(['user_id' => $author->id, 'content' => 'x']);

        $this->withHeaders($this->auth($liker))
            ->postJson("/api/posts/{$post->id}/like")
            ->assertOk()->assertJson(['liked' => true, 'likes_count' => 1]);

        $this->assertDatabaseHas('post_likes', ['post_id' => $post->id, 'user_id' => $liker->id]);

        $this->withHeaders($this->auth($liker))->getJson('/api/posts')
            ->assertJsonPath('data.0.liked', true);

        $this->withHeaders($this->auth($liker))
            ->postJson("/api/posts/{$post->id}/like")
            ->assertJson(['liked' => false, 'likes_count' => 0]);
    }

    public function test_comment_and_share(): void
    {
        $u = User::factory()->create();
        $post = Post::create(['user_id' => $u->id, 'content' => 'x']);

        $this->withHeaders($this->auth($u))
            ->postJson("/api/posts/{$post->id}/comments", ['body' => 'Nice!'])
            ->assertCreated()->assertJsonPath('body', 'Nice!');

        $this->assertSame(1, $post->fresh()->comments_count);
        $this->getJson("/api/posts/{$post->id}/comments")->assertOk()->assertJsonCount(1);

        $this->postJson("/api/posts/{$post->id}/share")->assertOk();
        $this->assertSame(1, $post->fresh()->shares_count);
    }

    public function test_only_the_author_can_delete_a_post(): void
    {
        $author = User::factory()->create();
        $other = User::factory()->create();
        $post = Post::create(['user_id' => $author->id, 'content' => 'x']);

        $this->withHeaders($this->auth($other))
            ->deleteJson("/api/posts/{$post->id}")->assertStatus(403);

        $this->withHeaders($this->auth($author))
            ->deleteJson("/api/posts/{$post->id}")->assertStatus(204);
        $this->assertDatabaseMissing('posts', ['id' => $post->id]);
    }

    public function test_admin_can_moderate(): void
    {
        $admin = User::factory()->create(['is_admin' => true]);
        $post = Post::create(['user_id' => $admin->id, 'content' => 'x']);

        $this->actingAs($admin)->get('/admin/posts')->assertOk()->assertSee('x');
        $this->actingAs($admin)->delete("/admin/posts/{$post->id}")
            ->assertRedirect(route('admin.posts.index'));
        $this->assertDatabaseMissing('posts', ['id' => $post->id]);
    }
}
