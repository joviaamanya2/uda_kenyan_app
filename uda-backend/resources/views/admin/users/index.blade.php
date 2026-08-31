@extends('admin.layout')
@section('title', 'App users')

@section('content')
    <form method="GET" class="flex gap-2 mb-5">
        <input type="text" name="q" value="{{ $search }}" placeholder="Search name or email…" class="input w-64">
        <button class="btn-ghost">Search</button>
        @if($search)<a href="{{ route('admin.users.index') }}" class="btn-ghost !ring-0 text-slate-500">Clear</a>@endif
    </form>

    <div class="card overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-slate-50 border-b border-slate-200">
                <tr>
                    <th class="th">Name</th>
                    <th class="th">Email</th>
                    <th class="th">Role</th>
                    <th class="th">Joined</th>
                    <th class="th text-right">Actions</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                @forelse($users as $u)
                    <tr class="hover:bg-slate-50/70 transition">
                        <td class="td font-medium text-slate-900">{{ $u->name }}</td>
                        <td class="td">{{ $u->email }}</td>
                        <td class="td">
                            @if($u->is_admin)
                                <span class="badge-green">Admin</span>
                            @else
                                <span class="badge-slate">Member</span>
                            @endif
                        </td>
                        <td class="td text-slate-500">{{ $u->created_at?->format('d M Y') }}</td>
                        <td class="td text-right whitespace-nowrap">
                            @if($u->id !== auth()->id())
                                <form method="POST" action="{{ route('admin.users.toggleAdmin', $u->id) }}" class="inline">
                                    @csrf @method('PATCH')
                                    <button class="link">{{ $u->is_admin ? 'Revoke admin' : 'Make admin' }}</button>
                                </form>
                                <form method="POST" action="{{ route('admin.users.destroy', $u->id) }}" class="inline"
                                      onsubmit="return confirm('Delete {{ $u->name }}?')">
                                    @csrf @method('DELETE')
                                    <button class="ml-3 text-red-600 font-medium hover:underline">Delete</button>
                                </form>
                            @else
                                <span class="badge-slate">You</span>
                            @endif
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="5" class="px-4 py-14 text-center text-sm text-slate-400">No users.</td></tr>
                @endforelse
                </tbody>
            </table>
        </div>
    </div>

    <div class="mt-4">{{ $users->links() }}</div>
@endsection
