@extends('admin.layout')
@section('title', 'Contact messages')

@section('content')
    <div class="flex gap-2 mb-5 text-sm">
        <a href="{{ route('admin.messages.index') }}"
           class="px-3 py-1.5 rounded-lg ring-1 {{ ! $filter ? 'bg-uda-green text-white ring-uda-green' : 'ring-slate-300 text-slate-600 hover:bg-slate-50' }}">All</a>
        <a href="{{ route('admin.messages.index', ['filter' => 'unread']) }}"
           class="px-3 py-1.5 rounded-lg ring-1 {{ $filter === 'unread' ? 'bg-uda-green text-white ring-uda-green' : 'ring-slate-300 text-slate-600 hover:bg-slate-50' }}">Unread</a>
    </div>

    <div class="space-y-3">
        @forelse($messages as $m)
            <div class="card card-pad {{ $m->read ? '' : 'ring-2 ring-uda-yellow' }}">
                <div class="flex flex-wrap items-start justify-between gap-2">
                    <div>
                        <div class="font-semibold text-slate-900">{{ $m->name }}
                            @unless($m->read)<span class="badge-amber ml-1.5 align-middle">New</span>@endunless
                        </div>
                        <div class="text-sm text-slate-500">
                            <a href="mailto:{{ $m->email }}" class="hover:underline">{{ $m->email }}</a>
                            · {{ $m->created_at?->format('d M Y H:i') }}
                        </div>
                    </div>
                    <div class="flex gap-2 text-sm">
                        <form method="POST" action="{{ route('admin.messages.toggleRead', $m->id) }}">
                            @csrf @method('PATCH')
                            <button class="btn-ghost !py-1.5">Mark {{ $m->read ? 'unread' : 'read' }}</button>
                        </form>
                        <form method="POST" action="{{ route('admin.messages.destroy', $m->id) }}"
                              onsubmit="return confirm('Delete this message?')">
                            @csrf @method('DELETE')
                            <button class="btn-danger !py-1.5">Delete</button>
                        </form>
                    </div>
                </div>
                @if($m->subject)<div class="mt-3 text-sm font-medium text-slate-800">{{ $m->subject }}</div>@endif
                <p class="mt-1 text-sm text-slate-600 whitespace-pre-line">{{ $m->message }}</p>
            </div>
        @empty
            <div class="card p-10 text-center text-sm text-slate-400">No messages.</div>
        @endforelse
    </div>

    <div class="mt-4">{{ $messages->links() }}</div>
@endsection
