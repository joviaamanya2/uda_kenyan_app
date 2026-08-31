@extends('admin.layout')
@section('title', 'Dashboard')

@section('content')
    <p class="text-sm text-slate-500 -mt-1 mb-6">Overview of party content and everything coming in from the app.</p>

    {{-- Key stats --}}
    <div class="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
        @php
            $tiles = [
                ['UDA members', $stats['total_members'], $stats['recent_members'] ? '+'.$stats['recent_members'].' this week' : null, 'idcard', route('admin.members.index')],
                ['App users', $stats['app_users'], null, 'users', route('admin.users.index')],
                ['Unread messages', $stats['unread_messages'], 'of '.$stats['total_messages'].' total', 'mail', route('admin.messages.index', ['filter' => 'unread'])],
                ['Unanswered questions', $stats['unanswered_questions'], 'of '.$stats['total_questions'].' total', 'chat', route('admin.questions.index', ['filter' => 'unanswered'])],
            ];
        @endphp
        @foreach($tiles as [$label, $value, $hint, $icon, $href])
            <a href="{{ $href }}" class="card card-pad group hover:shadow-md hover:-translate-y-0.5 transition">
                <div class="flex items-start justify-between">
                    <div class="w-10 h-10 rounded-xl bg-uda-greenLight text-uda-green grid place-items-center">
                        @include('admin.partials.icon', ['name' => $icon, 'class' => 'w-5 h-5'])
                    </div>
                    <span class="text-slate-300 group-hover:text-uda-green transition">
                        @include('admin.partials.icon', ['name' => 'dot', 'class' => 'w-2 h-2'])
                    </span>
                </div>
                <div class="mt-3 text-3xl font-extrabold text-slate-900 tabular-nums">{{ number_format($value) }}</div>
                <div class="text-sm text-slate-500">{{ $label }}</div>
                @if($hint)<div class="mt-1 text-xs font-medium text-uda-green">{{ $hint }}</div>@endif
            </a>
        @endforeach
    </div>

    {{-- Donations + content totals --}}
    <div class="grid lg:grid-cols-3 gap-4 mb-8">
        <a href="{{ route('admin.donations.index') }}" class="card card-pad hover:shadow-md transition">
            <div class="flex items-center gap-2 text-sm font-semibold text-slate-500 mb-3">
                @include('admin.partials.icon', ['name' => 'gift', 'class' => 'w-4 h-4']) Donations
                <span class="badge-slate ml-auto">{{ $stats['total_donations'] }}</span>
            </div>
            @forelse($stats['donations_raised'] as $currency => $sum)
                <div class="text-2xl font-extrabold text-uda-green leading-tight">{{ $currency }} {{ number_format($sum, 0) }}</div>
            @empty
                <div class="text-2xl font-extrabold text-slate-300">—</div>
            @endforelse
            <div class="text-xs text-slate-400 mt-1">Total pledged &amp; received</div>
        </a>

        <div class="card card-pad lg:col-span-2">
            <div class="flex items-center gap-2 text-sm font-semibold text-slate-500 mb-3">
                @include('admin.partials.icon', ['name' => 'folder', 'class' => 'w-4 h-4']) Content records
                <span class="badge-slate ml-auto">{{ collect($counts)->sum('total') }}</span>
            </div>
            <div class="grid grid-cols-2 sm:grid-cols-3 gap-2">
                @foreach($counts as $key => $row)
                    <a href="{{ route('admin.resource.index', $key) }}"
                       class="flex items-center justify-between rounded-lg px-3 py-2 text-sm ring-1 ring-slate-200 hover:ring-uda-green hover:bg-uda-greenLight/40 transition">
                        <span class="flex items-center gap-2 text-slate-600 min-w-0">
                            @include('admin.partials.icon', ['name' => \App\Admin\ResourceRegistry::icon($key), 'class' => 'w-4 h-4 text-slate-400'])
                            <span class="truncate">{{ $row['label'] }}</span>
                        </span>
                        <span class="font-bold text-slate-900">{{ $row['total'] }}</span>
                    </a>
                @endforeach
            </div>
        </div>
    </div>

    {{-- Charts --}}
    <div class="grid lg:grid-cols-5 gap-5 mb-5">
        <div class="card card-pad lg:col-span-3">
            <div class="flex items-center gap-2 text-sm font-semibold text-slate-700 mb-4">
                @include('admin.partials.icon', ['name' => 'users', 'class' => 'w-4 h-4 text-slate-400'])
                New app users per month
            </div>
            <div class="h-64"><canvas id="usersChart"></canvas></div>
        </div>

        <div class="card card-pad lg:col-span-2">
            <div class="flex items-center gap-2 text-sm font-semibold text-slate-700 mb-4">
                @include('admin.partials.icon', ['name' => 'gift', 'class' => 'w-4 h-4 text-slate-400'])
                Donations by category
            </div>
            @if($donationsPie['labels']->isEmpty())
                <div class="h-64 grid place-items-center text-sm text-slate-400">No donations yet.</div>
            @else
                <div class="h-64"><canvas id="donationsChart"></canvas></div>
            @endif
        </div>
    </div>

    {{-- Activity --}}
    <div class="grid md:grid-cols-2 gap-5">
        {{-- Latest messages --}}
        <div class="card">
            <div class="flex items-center justify-between px-5 py-3.5 border-b border-slate-100">
                <span class="font-semibold text-sm text-slate-800">Latest messages</span>
                <a href="{{ route('admin.messages.index') }}" class="text-xs link">View all</a>
            </div>
            <ul class="divide-y divide-slate-100">
                @forelse($recentMessages as $m)
                    <li class="px-5 py-3 {{ $m->read ? '' : 'bg-amber-50/60' }}">
                        <div class="flex items-center gap-2">
                            <span class="text-sm font-medium text-slate-800 truncate">{{ $m->name }}</span>
                            @unless($m->read)<span class="badge-amber">New</span>@endunless
                        </div>
                        <div class="text-xs text-slate-400 line-clamp-2">{{ $m->message }}</div>
                    </li>
                @empty
                    <li class="px-5 py-6 text-sm text-slate-400 text-center">No messages yet.</li>
                @endforelse
            </ul>
        </div>

        {{-- Latest questions --}}
        <div class="card">
            <div class="flex items-center justify-between px-5 py-3.5 border-b border-slate-100">
                <span class="font-semibold text-sm text-slate-800">Latest questions</span>
                <a href="{{ route('admin.questions.index') }}" class="text-xs link">View all</a>
            </div>
            <ul class="divide-y divide-slate-100">
                @forelse($recentQuestions as $q)
                    <li class="px-5 py-3">
                        <div class="text-sm text-slate-700 line-clamp-2">{{ $q->question_text }}</div>
                        <div class="text-xs mt-1 {{ $q->answer_text ? 'text-uda-green' : 'text-amber-600' }}">
                            {{ $q->answer_text ? 'Answered' : 'Awaiting answer' }} · {{ $q->user->name ?? 'Anonymous' }}
                        </div>
                    </li>
                @empty
                    <li class="px-5 py-6 text-sm text-slate-400 text-center">No questions yet.</li>
                @endforelse
            </ul>
        </div>
    </div>
@endsection

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
<script>
(function () {
    if (typeof Chart === 'undefined') return;
    Chart.defaults.font.family = "'Inter', sans-serif";
    Chart.defaults.color = '#64748b';

    const usersEl = document.getElementById('usersChart');
    if (usersEl) {
        new Chart(usersEl, {
            type: 'bar',
            data: {
                labels: @json($usersMonthly['labels']),
                datasets: [{
                    label: 'New users',
                    data: @json($usersMonthly['data']),
                    backgroundColor: '#1A5C2A',
                    borderRadius: 6,
                    maxBarThickness: 44,
                }],
            },
            options: {
                responsive: true, maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: {
                    y: { beginAtZero: true, ticks: { precision: 0 }, grid: { color: '#eef2f7' } },
                    x: { grid: { display: false } },
                },
            },
        });
    }

    const donEl = document.getElementById('donationsChart');
    if (donEl) {
        new Chart(donEl, {
            type: 'doughnut',
            data: {
                labels: @json($donationsPie['labels']),
                datasets: [{
                    data: @json($donationsPie['data']),
                    backgroundColor: ['#1A5C2A', '#FFCC00', '#4CAF6A', '#e0b400', '#123f1d', '#94a3b8', '#f59e0b', '#0ea5e9'],
                    borderWidth: 2,
                    borderColor: '#fff',
                }],
            },
            options: {
                responsive: true, maintainAspectRatio: false,
                cutout: '58%',
                plugins: {
                    legend: { position: 'bottom', labels: { boxWidth: 12, padding: 14 } },
                    tooltip: {
                        callbacks: {
                            label: (c) => ' ' + c.label + ': ' + c.parsed.toLocaleString(undefined, { maximumFractionDigits: 2 }),
                        },
                    },
                },
            },
        });
    }
})();
</script>
@endpush
