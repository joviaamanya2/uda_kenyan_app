<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Post;
use App\Models\PostComment;

class PostController extends Controller
{
    public function index()
    {
        $posts = Post::with('user')->withCount('comments')->latest()->paginate(20);

        return view('admin.posts.index', compact('posts'));
    }

    public function show(Post $post)
    {
        $post->load('user', 'comments.user');

        return view('admin.posts.show', compact('post'));
    }

    public function destroy(Post $post)
    {
        $post->delete();

        return redirect()->route('admin.posts.index')->with('success', 'Post deleted.');
    }

    public function destroyComment(PostComment $comment)
    {
        $postId = $comment->post_id;
        $comment->post()->decrement('comments_count');
        $comment->delete();

        return redirect()
            ->route('admin.posts.show', $postId)
            ->with('success', 'Comment deleted.');
    }
}
