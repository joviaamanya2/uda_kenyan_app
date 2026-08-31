@extends('admin.layout')
@section('title', 'Donations')

@section('content')
    {{-- Totals --}}
    <div class="flex flex-wrap gap-3 mb-5">
        @forelse($totalsByCurrency as $row)
            <div class="card px-4 py-3">
                <div class="text-lg font-extrabold text-uda-green">{{ $row->currency }} {{ number_format($row->total, 2) }}</div>
                <div class="text-xs text-slate-500">{{ $row->count }} donation{{ $row->count == 1 ? '' : 's' }}</div>
            </div>
        @empty
            <div class="card px-4 py-3 text-sm text-slate-400">No donations recorded yet.</div>
        @endforelse
    </div>

    <div class="flex flex-wrap items-center justify-between gap-3 mb-5">
        <div class="flex flex-wrap gap-2 text-sm">
            @php $tabs = ['' => 'All ('.$total.')', 'recent' => 'Recent ('.$recentCount.')', 'pledged' => 'Pledged', 'received' => 'Received']; @endphp
            @foreach($tabs as $key => $label)
                <a href="{{ route('admin.donations.index', array_filter(['filter' => $key ?: null, 'q' => $search])) }}"
                   class="px-3 py-1.5 rounded-lg ring-1 {{ (string) $filter === (string) $key ? 'bg-uda-green text-white ring-uda-green' : 'ring-slate-300 text-slate-600 hover:bg-slate-50' }}">
                    {{ $label }}
                </a>
            @endforeach
        </div>

        <form method="GET" class="flex gap-2">
            @if($filter)<input type="hidden" name="filter" value="{{ $filter }}">@endif
            <input type="text" name="q" value="{{ $search }}" placeholder="Name, email, category…" class="input w-56">
            <button class="btn-ghost">Search</button>
            @if($search)<a href="{{ route('admin.donations.index', array_filter(['filter' => $filter])) }}" class="btn-ghost !ring-0 text-slate-500">Clear</a>@endif
        </form>
    </div>

    @if($filter === 'recent')
        <p class="text-xs text-slate-400 mb-2">Showing donations from the last {{ $recentDays }} days.</p>
    @endif

    <div class="card overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-slate-50 border-b border-slate-200">
                <tr>
                    <th class="th">Donor</th>
                    <th class="th">Amount</th>
                    <th class="th">Category</th>
                    <th class="th">From</th>
                    <th class="th">Status</th>
                    <th class="th">Date</th>
                    <th class="th text-right">Actions</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                @forelse($donations as $d)
                    <tr class="hover:bg-slate-50/70 transition">
                        <td class="td">
                            <a href="{{ route('admin.donations.show', $d) }}" class="link">{{ $d->name }}</a>
                            <div class="text-slate-400 text-xs">{{ $d->email }}</div>
                        </td>
                        <td class="td font-semibold text-slate-900 whitespace-nowrap">{{ $d->currency }} {{ number_format($d->amount, 2) }}</td>
                        <td class="td">{{ $d->category ?: '—' }}</td>
                        <td class="td">{{ $d->location ?: '—' }}</td>
                        <td class="td">
                            <span class="{{ $d->status === 'received' ? 'badge-green' : 'badge-amber' }}">{{ ucfirst($d->status) }}</span>
                        </td>
                        <td class="td text-slate-500 whitespace-nowrap">{{ $d->created_at?->format('d M Y') }}</td>
                        <td class="td text-right whitespace-nowrap">
                            <form method="POST" action="{{ route('admin.donations.toggleStatus', $d) }}" class="inline">
                                @csrf @method('PATCH')
                                <button class="link">{{ $d->status === 'received' ? 'Mark pledged' : 'Mark received' }}</button>
                            </form>
                            <form method="POST" action="{{ route('admin.donations.destroy', $d) }}" class="inline"
                                  onsubmit="return confirm('Delete this donation record?')">
                                @csrf @method('DELETE')
                                <button class="ml-3 text-red-600 font-medium hover:underline">Delete</button>
                            </form>
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="7" class="px-4 py-14 text-center text-sm text-slate-400">No donations found.</td></tr>
                @endforelse
                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-4">{{ $donations->links() }}</div>
@endsection
