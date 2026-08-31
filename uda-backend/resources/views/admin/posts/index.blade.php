@extends('admin.layout')
@section('title', 'Community Posts')

@section('content')
    <p class="text-sm text-slate-500 mb-5">Posts from the app's community feed. Remove anything that breaks the rules.</p>

    <div class="space-y-3">
        @forelse($posts as $post)
            <div class="card card-pad">
                <div class="flex items-start justify-between gap-3">
                    <div class="min-w-0">
                        <div class="font-semibold text-slate-900">{{ $post->user->name ?? 'Deleted user' }}
                            <span class="text-slate-400 font-normal text-xs">· {{ $post->created_at?->diffForHumans() }}</span>
                        </div>
                        <p class="mt-1 text-sm text-slate-600 whitespace-pre-line">{{ \Illuminate\Support\Str::limit($post->content, 280) }}</p>
                        @if($post->image_path && $post->media_type === 'video')
                            <a href="{{ $post->image_path }}" target="_blank" class="inline-flex items-center gap-1.5 mt-2 text-xs font-medium text-uda-green">
                                <svg class="w-4 h-4" viewBox="0 0 24 24" fill="currentColor"><path d="M8 5v14l11-7z"/></svg> View video
                            </a>
                        @elseif($post->image_path)
                            <a href="{{ $post->image_path }}" target="_blank" class="inline-block mt-2">
                                <img src="{{ $post->image_path }}" alt="" class="h-20 rounded-lg ring-1 ring-slate-200 object-cover">
                            </a>
                        @endif
                        <div class="mt-2 text-xs text-slate-400">
                            {{ $post->likes_count }} likes · {{ $post->comments_count }} comments · {{ $post->shares_count }} shares
                        </div>
                    </div>
                    <div class="flex flex-col gap-2 text-sm shrink-0">
                        <a href="{{ route('admin.posts.show', $post) }}" class="link">View</a>
                        <form method="POST" action="{{ route('admin.posts.destroy', $post) }}"
                              onsubmit="return confirm('Delete this post and all its comments?')">
                            @csrf @method('DELETE')
                            <button class="text-red-600 font-medium hover:underline">Delete</button>
                        </form>
                    </div>
                </div>
            </div>
        @empty
            <div class="card p-10 text-center text-sm text-slate-400">No posts yet.</div>
        @endforelse
    </div>

    <div class="mt-4">{{ $posts->links() }}</div>
@endsection
