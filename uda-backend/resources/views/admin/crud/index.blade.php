@extends('admin.layout')
@section('title', $config['plural'])

@section('content')
    <div class="flex flex-wrap items-center justify-between gap-3 mb-5">
        <form method="GET" class="flex gap-2">
            <div class="relative">
                <span class="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">
                    <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"><circle cx="11" cy="11" r="7"/><path d="m20 20-3.5-3.5"/></svg>
                </span>
                <input type="text" name="q" value="{{ $search }}" placeholder="Search {{ strtolower($config['plural']) }}…"
                       class="input pl-9 w-64">
            </div>
            <button class="btn-ghost">Search</button>
            @if($search)
                <a href="{{ route('admin.resource.index', $resource) }}" class="btn-ghost !ring-0 text-slate-500">Clear</a>
            @endif
        </form>
        <a href="{{ route('admin.resource.create', $resource) }}" class="btn-accent">
            <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M12 5v14M5 12h14"/></svg>
            New {{ strtolower($config['label']) }}
        </a>
    </div>

    <div class="card overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-slate-50 border-b border-slate-200">
                <tr>
                    @foreach($config['columns'] as $key => $label)
                        <th class="th">{{ $label }}</th>
                    @endforeach
                    <th class="th text-right">Actions</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                @forelse($records as $record)
                    <tr class="hover:bg-slate-50/70 transition">
                        @foreach($config['columns'] as $key => $label)
                            <td class="td {{ $loop->first ? 'font-medium text-slate-900' : '' }}">
                                @php $value = $record->{$key}; @endphp
                                @if(is_bool($value))
                                    <span class="{{ $value ? 'badge-green' : 'badge-slate' }}">{{ $value ? 'Yes' : 'No' }}</span>
                                @elseif($value instanceof \DateTimeInterface)
                                    {{ $value->format('d M Y H:i') }}
                                @elseif($loop->first && ($value ?? '') !== '')
                                    <a href="{{ route('admin.resource.edit', [$resource, $record->id]) }}" class="link">{{ \Illuminate\Support\Str::limit((string) $value, 60) }}</a>
                                @else
                                    {{ \Illuminate\Support\Str::limit((string) $value, 60) ?: '—' }}
                                @endif
                            </td>
                        @endforeach
                        <td class="td text-right whitespace-nowrap">
                            <a href="{{ route('admin.resource.edit', [$resource, $record->id]) }}" class="link">Edit</a>
                            <form method="POST" action="{{ route('admin.resource.destroy', [$resource, $record->id]) }}"
                                  class="inline" onsubmit="return confirm('Delete this {{ strtolower($config['label']) }}?')">
                                @csrf @method('DELETE')
                                <button class="ml-3 text-red-600 font-medium hover:underline">Delete</button>
                            </form>
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="{{ count($config['columns']) + 1 }}" class="px-4 py-14 text-center">
                        <div class="mx-auto w-11 h-11 rounded-xl bg-slate-100 text-slate-400 grid place-items-center mb-3">
                            @include('admin.partials.icon', ['name' => \App\Admin\ResourceRegistry::icon($resource), 'class' => 'w-5 h-5'])
                        </div>
                        <p class="text-sm text-slate-500">No {{ strtolower($config['plural']) }} yet.</p>
                        <a href="{{ route('admin.resource.create', $resource) }}" class="text-sm link">Add the first one</a>
                    </td></tr>
                @endforelse
                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-4">{{ $records->links() }}</div>
@endsection
