@extends('admin.layout')
@section('title', 'Settings')

@section('content')
    <p class="text-sm text-slate-500 mb-5">
        These values are served to the app at <code class="text-xs bg-slate-100 rounded px-1.5 py-0.5">/api/settings</code> and appear on the
        About, Contact and Live TV screens.
    </p>

    <form method="POST" action="{{ route('admin.settings.update') }}" class="card card-pad space-y-8 max-w-2xl">
        @csrf
        @method('PUT')

        @foreach($schema as $group => $fields)
            <div>
                <h2 class="flex items-center gap-2 font-semibold text-uda-green mb-4">
                    <span class="w-1.5 h-4 rounded bg-uda-yellow"></span>{{ $group }}
                </h2>
                <div class="space-y-4">
                    @foreach($fields as $key => [$label, $type])
                        <div>
                            <label class="label">{{ $label }}</label>
                            @if($type === 'textarea')
                                <textarea name="{{ $key }}" rows="3" class="input">{{ old($key, $values[$key] ?? '') }}</textarea>
                            @else
                                <input type="{{ $type === 'url' ? 'url' : 'text' }}" name="{{ $key }}"
                                       value="{{ old($key, $values[$key] ?? '') }}" class="input">
                            @endif
                        </div>
                    @endforeach
                </div>
            </div>
        @endforeach

        <div class="pt-3 border-t border-slate-100">
            <button class="btn-primary">Save settings</button>
        </div>
    </form>
@endsection
