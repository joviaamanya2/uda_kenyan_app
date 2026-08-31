<!DOCTYPE html>
<html lang="en" class="h-full">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sign in — UDA Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = { theme: { extend: {
            fontFamily: { sans: ['Inter', 'ui-sans-serif', 'system-ui', 'sans-serif'] },
            colors: { uda: { green: '#1A5C2A', greenDark: '#123f1d', yellow: '#FFCC00', yellowDark: '#e0b400' } },
        } } }
    </script>
</head>
<body class="h-full font-sans antialiased bg-gradient-to-br from-uda-green via-uda-greenDark to-[#0c2c15] grid place-items-center p-4">
    <div class="w-full max-w-sm">
        <div class="flex items-center gap-3 mb-6 text-white">
            <div class="w-11 h-11 rounded-xl bg-uda-yellow text-uda-green font-black text-xl grid place-items-center shadow-lg">U</div>
            <div>
                <div class="font-bold text-lg leading-tight">UDA Admin</div>
                <div class="text-xs text-white/60">Content &amp; data console</div>
            </div>
        </div>

        <div class="bg-white rounded-2xl shadow-2xl p-8">
            <h1 class="text-lg font-bold text-slate-900">Sign in</h1>
            <p class="text-sm text-slate-500 mb-5">Enter your dashboard credentials.</p>

            @if(session('error'))
                <div class="mb-4 rounded-lg bg-red-50 ring-1 ring-red-200 text-red-800 px-3 py-2 text-sm">{{ session('error') }}</div>
            @endif
            @if(session('success'))
                <div class="mb-4 rounded-lg bg-green-50 ring-1 ring-green-200 text-green-800 px-3 py-2 text-sm">{{ session('success') }}</div>
            @endif

            <form method="POST" action="{{ route('admin.login.attempt') }}" class="space-y-4">
                @csrf
                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1.5">Email</label>
                    <input type="email" name="email" value="{{ old('email') }}" required autofocus
                           class="w-full rounded-lg ring-1 ring-slate-300 border-0 px-3 py-2.5 text-sm focus:ring-2 focus:ring-uda-green focus:outline-none">
                    @error('email')<p class="text-red-600 text-xs mt-1">{{ $message }}</p>@enderror
                </div>
                <div>
                    <label class="block text-sm font-medium text-slate-700 mb-1.5">Password</label>
                    <input type="password" name="password" required
                           class="w-full rounded-lg ring-1 ring-slate-300 border-0 px-3 py-2.5 text-sm focus:ring-2 focus:ring-uda-green focus:outline-none">
                    @error('password')<p class="text-red-600 text-xs mt-1">{{ $message }}</p>@enderror
                </div>
                <label class="flex items-center gap-2 text-sm text-slate-600">
                    <input type="checkbox" name="remember" value="1" class="h-4 w-4 rounded border-slate-300 text-uda-green focus:ring-uda-green"> Remember me
                </label>
                <button class="w-full bg-uda-yellow text-uda-green font-bold rounded-lg py-2.5 hover:bg-uda-yellowDark transition">
                    Sign in
                </button>
            </form>
        </div>

        <p class="text-center text-xs text-white/40 mt-6">United Democratic Alliance</p>
    </div>
</body>
</html>
