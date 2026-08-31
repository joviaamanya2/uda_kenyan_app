<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Member;
use Illuminate\Http\Request;

class MemberController extends Controller
{
    private const RECENT_DAYS = 7;

    public function index(Request $request)
    {
        $query = Member::latest();

        $filter = $request->query('filter');
        if ($filter === 'recent') {
            $query->where('created_at', '>=', now()->subDays(self::RECENT_DAYS));
        }

        if ($search = trim((string) $request->query('q'))) {
            $query->where(function ($q) use ($search) {
                $q->where('surname', 'like', "%{$search}%")
                    ->orWhere('other_name', 'like', "%{$search}%")
                    ->orWhere('phone', 'like', "%{$search}%")
                    ->orWhere('district', 'like', "%{$search}%")
                    ->orWhere('national_id_number', 'like', "%{$search}%");
            });
        }

        $members = $query->paginate(20)->withQueryString();

        $recentCount = Member::where('created_at', '>=', now()->subDays(self::RECENT_DAYS))->count();

        return view('admin.members.index', [
            'members' => $members,
            'filter' => $filter,
            'search' => $request->query('q'),
            'recentCount' => $recentCount,
            'recentDays' => self::RECENT_DAYS,
            'total' => Member::count(),
        ]);
    }

    public function show(Member $member)
    {
        return view('admin.members.show', compact('member'));
    }

    public function destroy(Member $member)
    {
        $member->delete();

        return redirect()
            ->route('admin.members.index')
            ->with('success', 'Member removed.');
    }
}
