@if(session('success'))
    <div class="mb-5 flex items-start gap-3 rounded-xl bg-uda-greenLight ring-1 ring-uda-green/20 text-uda-green px-4 py-3 text-sm">
        <svg class="w-5 h-5 shrink-0 mt-px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="m5 13 4 4L19 7"/></svg>
        <span>{{ session('success') }}</span>
    </div>
@endif

@if(session('error'))
    <div class="mb-5 flex items-start gap-3 rounded-xl bg-red-50 ring-1 ring-red-200 text-red-800 px-4 py-3 text-sm">
        <svg class="w-5 h-5 shrink-0 mt-px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 8v5M12 16h.01"/></svg>
        <span>{{ session('error') }}</span>
    </div>
@endif

@if($errors->any())
    <div class="mb-5 flex items-start gap-3 rounded-xl bg-red-50 ring-1 ring-red-200 text-red-800 px-4 py-3 text-sm">
        <svg class="w-5 h-5 shrink-0 mt-px" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/><path d="M12 8v5M12 16h.01"/></svg>
        <div>
            <div class="font-semibold mb-1">Please fix the following:</div>
            <ul class="list-disc list-inside space-y-0.5">
                @foreach($errors->all() as $error)
                    <li>{{ $error }}</li>
                @endforeach
            </ul>
        </div>
    </div>
@endif
