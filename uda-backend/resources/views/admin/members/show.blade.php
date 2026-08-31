@extends('admin.layout')
@section('title', $member->other_name.' '.$member->surname)

@section('content')
    <a href="{{ route('admin.members.index') }}" class="inline-flex items-center gap-1 text-sm text-slate-500 hover:text-slate-800">
        <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="m15 18-6-6 6-6"/></svg>
        Back to members
    </a>

    <div class="card card-pad mt-3 max-w-3xl">
        <div class="flex items-start justify-between gap-3">
            <div class="flex items-center gap-3">
                <div class="w-12 h-12 rounded-full bg-uda-greenLight text-uda-green grid place-items-center text-lg font-bold">
                    {{ strtoupper(mb_substr($member->other_name ?: $member->surname ?: '?', 0, 1)) }}
                </div>
                <div>
                    <h2 class="text-xl font-bold text-slate-900">{{ $member->other_name }} {{ $member->surname }}</h2>
                    <p class="text-sm text-slate-500">Joined {{ $member->created_at?->format('d M Y, H:i') }} ({{ $member->created_at?->diffForHumans() }})</p>
                </div>
            </div>
            <form method="POST" action="{{ route('admin.members.destroy', $member) }}" onsubmit="return confirm('Remove this member?')">
                @csrf @method('DELETE')
                <button class="btn-danger !py-1.5">Delete</button>
            </form>
        </div>

        <dl class="grid sm:grid-cols-2 gap-x-8 gap-y-3 mt-6 text-sm">
            @foreach([
                'Phone' => $member->phone,
                'National ID number' => $member->national_id_number,
                'Gender' => $member->gender,
                'District' => $member->district,
                'Sub-county' => $member->sub_county,
                'Parish' => $member->parish,
                'Village' => $member->village,
            ] as $label => $value)
                <div>
                    <dt class="text-slate-400 text-[11px] uppercase tracking-wider">{{ $label }}</dt>
                    <dd class="mt-0.5 text-slate-800">{{ $value ?: '—' }}</dd>
                </div>
            @endforeach
        </dl>

        <div class="mt-6 border-t border-slate-100 pt-4 text-sm space-y-2">
            <div>
                <span class="text-slate-400">Previously a UDA member:</span>
                <strong class="text-slate-800">{{ $member->was_in_uda ? 'Yes' : 'No' }}</strong>
                @if($member->was_in_uda && ($member->uda_from || $member->uda_to))
                    <span class="text-slate-500">({{ $member->uda_from ?: '?' }} → {{ $member->uda_to ?: '?' }})</span>
                @endif
            </div>
            <div>
                <span class="text-slate-400">Previously in another party:</span>
                <strong class="text-slate-800">{{ $member->was_in_other_party ? 'Yes' : 'No' }}</strong>
                @if($member->was_in_other_party && $member->previous_party)
                    <span class="text-slate-500">({{ $member->previous_party }})</span>
                @endif
            </div>
        </div>

        <div class="mt-6 border-t border-slate-100 pt-4">
            <h3 class="font-semibold text-sm mb-3 text-slate-800">National ID photos</h3>
            <div class="grid grid-cols-2 gap-4">
                @foreach(['Front' => $member->id_front_path, 'Back' => $member->id_back_path] as $side => $url)
                    <div>
                        <div class="text-xs text-slate-400 mb-1">{{ $side }}</div>
                        @if($url)
                            <a href="{{ $url }}" target="_blank">
                                <img src="{{ $url }}" alt="{{ $side }} ID" class="rounded-lg ring-1 ring-slate-200 w-full object-cover max-h-48">
                            </a>
                        @else
                            <div class="rounded-lg ring-1 ring-dashed ring-slate-300 h-32 grid place-items-center text-slate-300 text-sm">Not uploaded</div>
                        @endif
                    </div>
                @endforeach
            </div>
        </div>
    </div>
@endsection
