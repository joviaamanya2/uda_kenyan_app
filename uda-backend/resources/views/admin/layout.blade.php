<!DOCTYPE html>
<html lang="en" class="h-full">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('title', 'Dashboard') — UDA Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: { sans: ['Inter', 'ui-sans-serif', 'system-ui', 'sans-serif'] },
                    colors: {
                        uda: {
                            green: '#1A5C2A',
                            greenDark: '#123f1d',
                            greenLight: '#e9f3ec',
                            yellow: '#FFCC00',
                            yellowDark: '#e0b400',
                        },
                    },
                },
            },
        }
    </script>
    <style type="text/tailwindcss">
        @layer components {
            .card       { @apply bg-white rounded-xl ring-1 ring-slate-200/80 shadow-sm; }
            .card-pad   { @apply p-5 sm:p-6; }
            .btn        { @apply inline-flex items-center justify-center gap-2 rounded-lg px-4 py-2 text-sm font-semibold transition; }
            .btn-primary{ @apply btn bg-uda-green text-white hover:bg-uda-greenDark; }
            .btn-accent { @apply btn bg-uda-yellow text-uda-green hover:bg-uda-yellowDark; }
            .btn-ghost  { @apply btn ring-1 ring-slate-300 text-slate-700 hover:bg-slate-50; }
            .btn-danger { @apply btn ring-1 ring-red-200 text-red-600 hover:bg-red-50; }
            .input      { @apply w-full rounded-lg ring-1 ring-slate-300 border-0 px-3 py-2 text-sm text-slate-800 placeholder:text-slate-400 focus:ring-2 focus:ring-uda-green focus:outline-none; }
            .label      { @apply block text-sm font-medium text-slate-700 mb-1.5; }
            .badge      { @apply inline-flex items-center gap-1 rounded-full px-2.5 py-0.5 text-xs font-semibold; }
            .badge-green{ @apply badge bg-uda-greenLight text-uda-green; }
            .badge-amber{ @apply badge bg-amber-100 text-amber-700; }
            .badge-slate{ @apply badge bg-slate-100 text-slate-500; }
            .th         { @apply px-4 py-3 text-left text-[11px] font-semibold uppercase tracking-wider text-slate-500; }
            .td         { @apply px-4 py-3 text-sm text-slate-700 align-middle; }
            .link       { @apply text-uda-green font-medium hover:underline; }
            .nav-link   { @apply flex items-center gap-3 rounded-lg px-3 py-2 text-sm font-medium text-white/80 hover:bg-white/10 hover:text-white transition; }
            .nav-link-active { @apply bg-white/15 text-white shadow-inner; }
            .section-title { @apply px-3 text-[11px] font-semibold uppercase tracking-wider text-white/40 mb-1.5; }
        }
        ::-webkit-scrollbar { width: 8px; height: 8px; }
        ::-webkit-scrollbar-thumb { background: rgba(100,116,139,.35); border-radius: 9999px; }
        #sidebar::-webkit-scrollbar-thumb { background: rgba(255,255,255,.18); }
    </style>
</head>
<body class="h-full bg-slate-50 text-slate-800 font-sans antialiased">
@php
    $groups = \App\Admin\ResourceRegistry::grouped();
    $unread   = \App\Models\ContactMessage::where('read', false)->count();
    $pending  = \App\Models\Question::whereNull('answer_text')->count();
    $recentM  = \App\Models\Member::where('created_at', '>=', now()->subDays(7))->count();
    $recentD  = \App\Models\Donation::where('created_at', '>=', now()->subDays(7))->count();
@endphp

<div class="lg:flex min-h-full">
    {{-- Mobile overlay --}}
    <div id="overlay" onclick="toggleSidebar(false)"
         class="fixed inset-0 z-30 bg-slate-900/50 backdrop-blur-sm hidden lg:hidden"></div>

    {{-- Sidebar --}}
    <aside id="sidebar"
           class="fixed lg:sticky top-0 z-40 h-screen w-72 lg:w-64 shrink-0 -translate-x-full lg:translate-x-0
                  transition-transform duration-200 ease-out overflow-y-auto
                  bg-gradient-to-b from-uda-green to-uda-greenDark text-white">
        <div class="px-5 py-4 flex items-center gap-3 border-b border-white/10">
            <div class="w-10 h-10 rounded-xl bg-uda-yellow text-uda-green font-black text-lg grid place-items-center shadow">U</div>
            <div class="min-w-0">
                <div class="font-bold leading-tight">UDA Admin</div>
                <div class="text-[11px] text-white/55">Content &amp; data console</div>
            </div>
            <button onclick="toggleSidebar(false)" class="lg:hidden ml-auto text-white/70 hover:text-white">
                @include('admin.partials.icon', ['name' => 'x'])
            </button>
        </div>

        <nav class="px-3 py-4 space-y-6 pb-16">
            <div class="space-y-1">
                <a href="{{ route('admin.dashboard') }}"
                   class="nav-link {{ request()->routeIs('admin.dashboard') ? 'nav-link-active' : '' }}">
                    @include('admin.partials.icon', ['name' => 'home']) Dashboard
                </a>
                <a href="{{ route('admin.users.index') }}"
                   class="nav-link {{ request()->routeIs('admin.users.*') ? 'nav-link-active' : '' }}">
                    @include('admin.partials.icon', ['name' => 'users']) App users
                </a>
            </div>

            <div>
                <div class="section-title">Inbox</div>
                <div class="space-y-1">
                    @php
                        $inbox = [
                            ['admin.messages.index',  'admin.messages.*',  'mail',   'Contact messages', $unread],
                            ['admin.questions.index', 'admin.questions.*', 'chat',   'Questions',        $pending],
                            ['admin.posts.index',     'admin.posts.*',     'photo',  'Community posts',  null],
                            ['admin.members.index',   'admin.members.*',   'idcard', 'UDA members',      $recentM],
                            ['admin.donations.index', 'admin.donations.*', 'gift',   'Donations',        $recentD],
                        ];
                    @endphp
                    @foreach($inbox as [$route, $pattern, $icon, $label, $count])
                        <a href="{{ route($route) }}"
                           class="nav-link {{ request()->routeIs($pattern) ? 'nav-link-active' : '' }}">
                            @include('admin.partials.icon', ['name' => $icon])
                            <span class="flex-1">{{ $label }}</span>
                            @if($count)
                                <span class="bg-uda-yellow text-uda-green text-[11px] font-bold rounded-full px-1.5 min-w-[20px] text-center">{{ $count }}</span>
                            @endif
                        </a>
                    @endforeach
                </div>
            </div>

            @foreach($groups as $groupName => $items)
                <div>
                    <div class="section-title">{{ $groupName }}</div>
                    <div class="space-y-1">
                        @foreach($items as $key => $label)
                            <a href="{{ route('admin.resource.index', $key) }}"
                               class="nav-link {{ (request()->route('resource') === $key) ? 'nav-link-active' : '' }}">
                                @include('admin.partials.icon', ['name' => \App\Admin\ResourceRegistry::icon($key)])
                                {{ $label }}
                            </a>
                        @endforeach
                    </div>
                </div>
            @endforeach

            <div class="pt-4 mt-2 border-t border-white/10">
                <a href="{{ route('admin.settings.edit') }}"
                   class="nav-link {{ request()->routeIs('admin.settings.*') ? 'nav-link-active' : '' }}">
                    @include('admin.partials.icon', ['name' => 'cog']) Settings
                </a>
            </div>
        </nav>
    </aside>

    {{-- Main --}}
    <div class="flex-1 min-w-0 flex flex-col">
        <header class="sticky top-0 z-20 bg-white/90 backdrop-blur border-b border-slate-200">
            <div class="px-4 sm:px-6 py-3 flex items-center gap-3">
                <button onclick="toggleSidebar(true)" class="lg:hidden text-slate-500 hover:text-slate-800">
                    @include('admin.partials.icon', ['name' => 'menu'])
                </button>
                <h1 class="text-base sm:text-lg font-bold text-slate-900 truncate">@yield('title', 'Dashboard')</h1>
                <div class="ml-auto flex items-center gap-3">
                    <div class="hidden sm:flex items-center gap-2 text-sm">
                        <div class="w-8 h-8 rounded-full bg-uda-greenLight text-uda-green font-bold grid place-items-center text-xs">
                            {{ strtoupper(mb_substr(auth()->user()->name, 0, 1)) }}
                        </div>
                        <span class="text-slate-600 font-medium">{{ auth()->user()->name }}</span>
                    </div>
                    <form method="POST" action="{{ route('admin.logout') }}">
                        @csrf
                        <button class="btn-ghost !py-1.5">
                            @include('admin.partials.icon', ['name' => 'logout']) <span class="hidden sm:inline">Sign out</span>
                        </button>
                    </form>
                </div>
            </div>
        </header>

        <main class="p-4 sm:p-6 lg:p-8 max-w-7xl w-full mx-auto flex-1">
            @include('admin.partials.flash')
            @yield('content')
        </main>

        <footer class="px-6 py-4 text-center text-xs text-slate-400">
            UDA Admin · United Democratic Alliance
        </footer>
    </div>
</div>

<script>
    function toggleSidebar(open) {
        const s = document.getElementById('sidebar');
        const o = document.getElementById('overlay');
        s.classList.toggle('-translate-x-full', !open);
        o.classList.toggle('hidden', !open);
    }
</script>
@stack('scripts')
</body>
</html>
