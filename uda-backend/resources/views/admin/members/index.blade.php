@extends('admin.layout')
@section('title', 'UDA Members')

@section('content')
    <div class="flex flex-wrap items-center justify-between gap-3 mb-5">
        <div class="flex gap-2 text-sm">
            <a href="{{ route('admin.members.index', array_filter(['q' => $search])) }}"
               class="px-3 py-1.5 rounded-lg ring-1 {{ ! $filter ? 'bg-uda-green text-white ring-uda-green' : 'ring-slate-300 text-slate-600 hover:bg-slate-50' }}">
                All <span class="opacity-70">({{ $total }})</span>
            </a>
            <a href="{{ route('admin.members.index', array_filter(['filter' => 'recent', 'q' => $search])) }}"
               class="px-3 py-1.5 rounded-lg ring-1 {{ $filter === 'recent' ? 'bg-uda-green text-white ring-uda-green' : 'ring-slate-300 text-slate-600 hover:bg-slate-50' }}">
                Recently joined <span class="opacity-70">({{ $recentCount }})</span>
            </a>
        </div>

        <form method="GET" class="flex gap-2">
            @if($filter)<input type="hidden" name="filter" value="{{ $filter }}">@endif
            <input type="text" name="q" value="{{ $search }}" placeholder="Name, phone, district, ID…" class="input w-64">
            <button class="btn-ghost">Search</button>
            @if($search)<a href="{{ route('admin.members.index', array_filter(['filter' => $filter])) }}" class="btn-ghost !ring-0 text-slate-500">Clear</a>@endif
        </form>
    </div>

    @if($filter === 'recent')
        <p class="text-xs text-slate-400 mb-2">Showing members who joined in the last {{ $recentDays }} days.</p>
    @endif

    <div class="card overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-slate-50 border-b border-slate-200">
                <tr>
                    <th class="th">Name</th>
                    <th class="th">Phone</th>
                    <th class="th">Gender</th>
                    <th class="th">District</th>
                    <th class="th">ID photos</th>
                    <th class="th">Joined</th>
                    <th class="th text-right">Actions</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                @forelse($members as $m)
                    <tr class="hover:bg-slate-50/70 transition">
                        <td class="td font-medium text-slate-900">
                            <a href="{{ route('admin.members.show', $m) }}" class="link">{{ $m->other_name }} {{ $m->surname }}</a>
                        </td>
                        <td class="td">{{ $m->phone }}</td>
                        <td class="td">{{ $m->gender ?: '—' }}</td>
                        <td class="td">{{ $m->district ?: '—' }}</td>
                        <td class="td">
                            @if($m->id_front_path || $m->id_back_path)
                                <span class="badge-green">{{ ($m->id_front_path ? 1 : 0) + ($m->id_back_path ? 1 : 0) }}/2</span>
                            @else
                                <span class="badge-slate">none</span>
                            @endif
                        </td>
                        <td class="td text-slate-500">{{ $m->created_at?->format('d M Y') }}</td>
                        <td class="td text-right whitespace-nowrap">
                            <a href="{{ route('admin.members.show', $m) }}" class="link">View</a>
                            <form method="POST" action="{{ route('admin.members.destroy', $m) }}" class="inline"
                                  onsubmit="return confirm('Remove this member?')">
                                @csrf @method('DELETE')
                                <button class="ml-3 text-red-600 font-medium hover:underline">Delete</button>
                            </form>
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="7" class="px-4 py-14 text-center text-sm text-slate-400">No members{{ $filter === 'recent' ? ' joined recently' : ' yet' }}.</td></tr>
                @endforelse
                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-4">{{ $members->links() }}</div>
@endsection
