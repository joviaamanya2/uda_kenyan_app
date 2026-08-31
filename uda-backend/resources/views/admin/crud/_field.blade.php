@php
    $name = $field['name'];
    $type = $field['type'];
    $label = $field['label'];
    $inputClass = 'input';

    $raw = old($name, $record->{$name} ?? ($field['default'] ?? null));

    $value = $raw;
    if (($type === 'date' || $type === 'datetime')) {
        $fmt = $type === 'date' ? 'Y-m-d' : 'Y-m-d\TH:i';
        try {
            if ($raw instanceof \DateTimeInterface) {
                $value = $raw->format($fmt);
            } elseif (is_string($raw) && $raw !== '') {
                $value = \Illuminate\Support\Carbon::parse($raw)->format($fmt);
            }
        } catch (\Throwable $e) {
            $value = is_string($raw) ? $raw : '';
        }
    }
    $isRequired = str_contains($field['rules'] ?? '', 'required') && ! str_contains($field['rules'] ?? '', 'sometimes');
@endphp

<div>
    <label class="label">
        {{ $label }}
        @if($isRequired && ! in_array($type, ['image', 'file', 'boolean']))<span class="text-red-500">*</span>@endif
    </label>

    @if($type === 'textarea')
        <textarea name="{{ $name }}" rows="{{ $field['rows'] ?? 4 }}" class="{{ $inputClass }}">{{ $value }}</textarea>

    @elseif($type === 'boolean')
        <label class="inline-flex items-center gap-2.5 text-sm cursor-pointer select-none">
            <input type="checkbox" name="{{ $name }}" value="1" @checked((bool) $raw)
                   class="h-4 w-4 rounded border-slate-300 text-uda-green focus:ring-uda-green">
            <span class="text-slate-600">Enabled</span>
        </label>

    @elseif($type === 'select')
        <select name="{{ $name }}" class="{{ $inputClass }}">
            @if(! $isRequired)<option value="">—</option>@endif
            @foreach($field['options'] as $optValue => $optLabel)
                <option value="{{ $optValue }}" @selected((string) $value === (string) $optValue)>{{ $optLabel }}</option>
            @endforeach
        </select>

    @elseif($type === 'number')
        <input type="number" name="{{ $name }}" value="{{ $value }}" step="{{ $field['step'] ?? '1' }}" class="{{ $inputClass }}">

    @elseif($type === 'date')
        <input type="date" name="{{ $name }}" value="{{ $value }}" class="{{ $inputClass }}">

    @elseif($type === 'datetime')
        <input type="datetime-local" name="{{ $name }}" value="{{ $value }}" class="{{ $inputClass }}">

    @elseif($type === 'image' || $type === 'file')
        @if($raw)
            <div class="mb-2 flex items-center gap-3 text-sm rounded-lg ring-1 ring-slate-200 p-2">
                @if($type === 'image')
                    <img src="{{ $raw }}" alt="" class="h-14 w-14 object-cover rounded-lg ring-1 ring-slate-200">
                @endif
                <a href="{{ $raw }}" target="_blank" class="link break-all flex-1 min-w-0 truncate">{{ $raw }}</a>
                <label class="flex items-center gap-1.5 text-red-600 shrink-0">
                    <input type="checkbox" name="{{ $name }}_remove" value="1" class="h-4 w-4 rounded border-slate-300 text-red-600 focus:ring-red-500"> remove
                </label>
            </div>
        @endif
        <input type="file" name="{{ $name }}" @if($type === 'image') accept="image/*" @endif
               class="block w-full text-sm text-slate-500 file:mr-3 file:rounded-lg file:border-0 file:bg-uda-greenLight file:text-uda-green file:font-semibold file:px-3 file:py-2 file:text-sm hover:file:bg-uda-green hover:file:text-white file:transition">
        <input type="text" name="{{ $name }}_url" value="{{ old($name.'_url') }}" placeholder="…or paste an image/file URL"
               class="{{ $inputClass }} mt-2">

    @else
        <input type="text" name="{{ $name }}" value="{{ $value }}" class="{{ $inputClass }}">
    @endif

    @if(! empty($field['note']))
        <p class="text-xs text-slate-400 mt-1.5">{{ $field['note'] }}</p>
    @endif
    @error($name)<p class="text-red-600 text-xs mt-1.5">{{ $message }}</p>@enderror
</div>
