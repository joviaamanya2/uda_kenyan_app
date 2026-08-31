<?php

namespace App\Http\Controllers;

use App\Models\Post;
use App\Models\PostComment;
use App\Models\PostLike;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class PostController extends Controller
{
    /** Resolve the user from a Bearer token if present — no error when absent. */
    private function optionalUser(Request $request): ?User
    {
        $header = $request->header('Authorization', '');
        $token = str_starts_with($header, 'Bearer ') ? substr($header, 7) : null;
        if (! $token) {
            return null;
        }

        return User::where('api_token', hash('sha256', $token))->first();
    }

    private function present(Post $post, ?int $userId, array $likedIds = []): array
    {
        return [
            'id' => $post->id,
            'content' => $post->content,
            'image_path' => $post->image_path,
            'media_type' => $post->media_type,
            'likes_count' => $post->likes_count,
            'comments_count' => $post->comments_count,
            'shares_count' => $post->shares_count,
            'created_at' => $post->created_at,
            'liked' => in_array($post->id, $likedIds, true),
            'is_mine' => $userId !== null && $post->user_id === $userId,
            'author' => [
                'name' => $post->user->name ?? 'UDA Member',
                'avatar_path' => $post->user->avatar_path ?? null,
                'county' => $post->user->county ?? null,
            ],
        ];
    }

    public function index(Request $request)
    {
        $user = $this->optionalUser($request);

        $posts = Post::with('user')->latest()->paginate(15);

        $likedIds = $user
            ? PostLike::where('user_id', $user->id)
                ->whereIn('post_id', $posts->pluck('id'))
                ->pluck('post_id')->all()
            : [];

        return response()->json([
            'data' => $posts->getCollection()
                ->map(fn (Post $p) => $this->present($p, $user?->id, $likedIds)),
            'current_page' => $posts->currentPage(),
            'last_page' => $posts->lastPage(),
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'content' => 'nullable|string|max:2000',
            // A single media file: an image (<= 8 MB) or a video (<= 80 MB).
            'media' => 'nullable|file|mimetypes:image/jpeg,image/png,image/webp,image/gif,video/mp4,video/quicktime,video/x-matroska,video/3gpp,video/webm|max:81920',
        ]);

        if (! $request->filled('content') && ! $request->hasFile('media')) {
            throw ValidationException::withMessages([
                'content' => 'Write something or attach a photo or video.',
            ]);
        }

        $mediaUrl = null;
        $mediaType = null;
        if ($request->hasFile('media')) {
            $file = $request->file('media');
            $mediaType = str_starts_with((string) $file->getMimeType(), 'video/') ? 'video' : 'image';
            if ($mediaType === 'image' && $file->getSize() > 8 * 1024 * 1024) {
                throw ValidationException::withMessages([
                    'media' => 'Images must be 8 MB or smaller.',
                ]);
            }
            $name = Str::random(20).'.'.$file->getClientOriginalExtension();
            $path = $file->storeAs('uploads/posts', $name, 'public');
            $mediaUrl = url('storage/'.$path);
        }

        $post = Post::create([
            'user_id' => $request->user()->id,
            'content' => (string) $request->input('content', ''),
            'image_path' => $mediaUrl,
            'media_type' => $mediaType,
        ]);
        $post->refresh()->load('user');

        return response()->json($this->present($post, $request->user()->id), 201);
    }

    public function destroy(Request $request, Post $post)
    {
        abort_unless($post->user_id === $request->user()->id, 403);
        $post->delete();

        return response()->json(null, 204);
    }

    public function toggleLike(Request $request, Post $post)
    {
        $userId = $request->user()->id;
        $existing = PostLike::where('post_id', $post->id)->where('user_id', $userId)->first();

        if ($existing) {
            $existing->delete();
            $post->decrement('likes_count');
            $liked = false;
        } else {
            PostLike::create(['post_id' => $post->id, 'user_id' => $userId]);
            $post->increment('likes_count');
            $liked = true;
        }

        return response()->json(['liked' => $liked, 'likes_count' => $post->fresh()->likes_count]);
    }

    public function share(Post $post)
    {
        $post->increment('shares_count');

        return response()->json(['shares_count' => $post->fresh()->shares_count]);
    }

    public function comments(Post $post)
    {
        return response()->json(
            $post->comments()->with('user')->get()->map(fn (PostComment $c) => [
                'id' => $c->id,
                'body' => $c->body,
                'created_at' => $c->created_at,
                'author' => [
                    'name' => $c->user->name ?? 'UDA Member',
                    'avatar_path' => $c->user->avatar_path ?? null,
                ],
            ])
        );
    }

    public function addComment(Request $request, Post $post)
    {
        $data = $request->validate(['body' => 'required|string|max:1000']);

        $comment = $post->comments()->create([
            'user_id' => $request->user()->id,
            'body' => $data['body'],
        ])->load('user');
        $post->increment('comments_count');

        return response()->json([
            'id' => $comment->id,
            'body' => $comment->body,
            'created_at' => $comment->created_at,
            'author' => [
                'name' => $comment->user->name,
                'avatar_path' => $comment->user->avatar_path,
            ],
        ], 201);
    }
}
