@extends('admin.layout')
@section('title', 'Post')

@section('content')
    <a href="{{ route('admin.posts.index') }}" class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-800">
        <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="m15 18-6-6 6-6"/></svg>
        Back to posts
    </a>

    <div class="card card-pad mt-3 max-w-2xl">
        <div class="flex items-start justify-between gap-3">
            <div class="flex items-center gap-3">
                <div class="w-9 h-9 rounded-full bg-slate-100 text-slate-500 grid place-items-center text-sm font-bold">
                    {{ strtoupper(mb_substr($post->user->name ?? '?', 0, 1)) }}
                </div>
                <div>
                    <div class="font-semibold text-slate-900">{{ $post->user->name ?? 'Deleted user' }}</div>
                    <div class="text-xs text-slate-400">{{ $post->created_at?->format('d M Y, H:i') }}</div>
                </div>
            </div>
            <form method="POST" action="{{ route('admin.posts.destroy', $post) }}" onsubmit="return confirm('Delete this post?')">
                @csrf @method('DELETE')
                <button class="btn-danger !py-1.5">Delete post</button>
            </form>
        </div>

        <p class="mt-4 text-sm text-slate-700 whitespace-pre-line">{{ $post->content }}</p>
        @if($post->image_path && $post->media_type === 'video')
            <video src="{{ $post->image_path }}" controls class="mt-3 rounded-lg ring-1 ring-slate-200 max-h-80 w-full"></video>
        @elseif($post->image_path)
            <img src="{{ $post->image_path }}" alt="" class="mt-3 rounded-lg ring-1 ring-slate-200 max-h-80">
        @endif
        <div class="mt-3 text-xs text-slate-400">
            {{ $post->likes_count }} likes · {{ $post->comments_count }} comments · {{ $post->shares_count }} shares
        </div>
    </div>

    <h2 class="font-semibold mt-6 mb-2 text-slate-800">Comments ({{ $post->comments->count() }})</h2>
    <div class="space-y-2 max-w-2xl">
        @forelse($post->comments as $comment)
            <div class="card p-3 flex items-start justify-between gap-3">
                <div>
                    <div class="text-sm font-medium text-slate-800">{{ $comment->user->name ?? 'Deleted user' }}
                        <span class="text-slate-400 font-normal text-xs">· {{ $comment->created_at?->diffForHumans() }}</span>
                    </div>
                    <p class="text-sm text-slate-600 mt-0.5">{{ $comment->body }}</p>
                </div>
                <form method="POST" action="{{ route('admin.comments.destroy', $comment) }}" onsubmit="return confirm('Delete this comment?')">
                    @csrf @method('DELETE')
                    <button class="text-red-600 hover:underline text-xs font-medium">Delete</button>
                </form>
            </div>
        @empty
            <p class="text-sm text-slate-400">No comments.</p>
        @endforelse
    </div>
@endsection
