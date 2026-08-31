@extends('admin.layout')
@section('title', 'Donation · '.$donation->name)

@section('content')
    <a href="{{ route('admin.donations.index') }}" class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-800">
        <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="m15 18-6-6 6-6"/></svg>
        Back to donations
    </a>

    <div class="card card-pad mt-3 max-w-2xl">
        <div class="flex items-start justify-between">
            <div>
                <div class="text-2xl font-extrabold text-uda-green">{{ $donation->currency }} {{ number_format($donation->amount, 2) }}</div>
                <p class="text-sm text-slate-500">
                    {{ $donation->created_at?->format('d M Y, H:i') }} ({{ $donation->created_at?->diffForHumans() }})
                </p>
            </div>
            <span class="{{ $donation->status === 'received' ? 'badge-green' : 'badge-amber' }}">{{ ucfirst($donation->status) }}</span>
        </div>

        <dl class="grid sm:grid-cols-2 gap-x-8 gap-y-3 mt-6 text-sm">
            @foreach([
                'Donor name' => $donation->name,
                'Email' => $donation->email,
                'Category' => $donation->category,
                'Funding from' => $donation->location,
            ] as $label => $value)
                <div>
                    <dt class="text-slate-400 text-[11px] uppercase tracking-wider">{{ $label }}</dt>
                    <dd class="mt-0.5 text-slate-800">{{ $value ?: '—' }}</dd>
                </div>
            @endforeach
        </dl>

        @if($donation->comment)
            <div class="mt-6 border-t border-slate-100 pt-4 text-sm">
                <div class="text-slate-400 text-[11px] uppercase tracking-wider mb-1">Comment</div>
                <p class="whitespace-pre-line text-slate-700">{{ $donation->comment }}</p>
            </div>
        @endif

        <div class="mt-6 border-t border-slate-100 pt-4 flex gap-3">
            <form method="POST" action="{{ route('admin.donations.toggleStatus', $donation) }}">
                @csrf @method('PATCH')
                <button class="btn-ghost">{{ $donation->status === 'received' ? 'Mark as pledged' : 'Mark as received' }}</button>
            </form>
            <form method="POST" action="{{ route('admin.donations.destroy', $donation) }}"
                  onsubmit="return confirm('Delete this donation record?')">
                @csrf @method('DELETE')
                <button class="btn-danger">Delete</button>
            </form>
        </div>
    </div>
@endsection
