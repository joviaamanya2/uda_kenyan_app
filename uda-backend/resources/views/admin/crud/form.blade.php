@extends('admin.layout')
@section('title', ($record->exists ? 'Edit ' : 'New ') . strtolower($config['label']))

@section('content')
    <a href="{{ route('admin.resource.index', $resource) }}"
       class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-800">
        <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="m15 18-6-6 6-6"/></svg>
        Back to {{ strtolower($config['plural']) }}
    </a>

    <form method="POST"
          action="{{ $record->exists ? route('admin.resource.update', [$resource, $record->id]) : route('admin.resource.store', $resource) }}"
          enctype="multipart/form-data"
          class="card card-pad mt-3 space-y-5 max-w-2xl">
        @csrf
        @if($record->exists) @method('PUT') @endif

        @foreach($config['fields'] as $field)
            @include('admin.crud._field', ['field' => $field, 'record' => $record])
        @endforeach

        <div class="flex gap-3 pt-3 border-t border-slate-100">
            <button class="btn-primary">{{ $record->exists ? 'Save changes' : 'Create' }}</button>
            <a href="{{ route('admin.resource.index', $resource) }}" class="btn-ghost">Cancel</a>
        </div>
    </form>
@endsection
