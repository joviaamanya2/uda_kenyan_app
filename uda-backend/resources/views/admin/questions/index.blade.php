@extends('admin.layout')
@section('title', 'Questions')

@section('content')
    <div class="flex gap-2 mb-5 text-sm">
        <a href="{{ route('admin.questions.index') }}"
           class="px-3 py-1.5 rounded-lg ring-1 {{ ! $filter ? 'bg-uda-green text-white ring-uda-green' : 'ring-slate-300 text-slate-600 hover:bg-slate-50' }}">All</a>
        <a href="{{ route('admin.questions.index', ['filter' => 'unanswered']) }}"
           class="px-3 py-1.5 rounded-lg ring-1 {{ $filter === 'unanswered' ? 'bg-uda-green text-white ring-uda-green' : 'ring-slate-300 text-slate-600 hover:bg-slate-50' }}">Unanswered</a>
    </div>

    <div class="space-y-3">
        @forelse($questions as $q)
            <div class="card card-pad">
                <div class="flex items-start justify-between gap-2">
                    <div class="text-xs text-slate-500">
                        {{ $q->user->name ?? 'Anonymous' }}
                        @if($q->user?->email) · {{ $q->user->email }} @endif
                        · {{ $q->created_at?->format('d M Y H:i') }}
                    </div>
                    <form method="POST" action="{{ route('admin.questions.destroy', $q->id) }}"
                          onsubmit="return confirm('Delete this question?')">
                        @csrf @method('DELETE')
                        <button class="text-red-600 text-sm font-medium hover:underline">Delete</button>
                    </form>
                </div>

                <p class="mt-2 font-medium text-slate-800 whitespace-pre-line">{{ $q->question_text }}</p>

                <form method="POST" action="{{ route('admin.questions.answer', $q->id) }}" class="mt-3">
                    @csrf @method('PATCH')
                    <textarea name="answer_text" rows="3" required class="input" placeholder="Write an answer…">{{ old('answer_text', $q->answer_text) }}</textarea>
                    <div class="flex items-center justify-between mt-2">
                        <span class="text-xs {{ $q->answer_text ? 'text-uda-green' : 'text-amber-600' }}">
                            {{ $q->answer_text ? 'Answered '.$q->answered_at?->diffForHumans() : 'Not answered yet' }}
                        </span>
                        <button class="btn-primary !py-2">{{ $q->answer_text ? 'Update answer' : 'Post answer' }}</button>
                    </div>
                </form>
            </div>
        @empty
            <div class="card p-10 text-center text-sm text-slate-400">No questions.</div>
        @endforelse
    </div>

    <div class="mt-4">{{ $questions->links() }}</div>
@endsection
