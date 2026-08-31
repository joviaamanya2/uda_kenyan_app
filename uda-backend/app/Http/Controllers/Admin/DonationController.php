<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Donation;
use Illuminate\Http\Request;

class DonationController extends Controller
{
    private const RECENT_DAYS = 7;

    public function index(Request $request)
    {
        $query = Donation::latest();

        $filter = $request->query('filter');
        if ($filter === 'recent') {
            $query->where('created_at', '>=', now()->subDays(self::RECENT_DAYS));
        } elseif (in_array($filter, ['pledged', 'received'], true)) {
            $query->where('status', $filter);
        }

        if ($search = trim((string) $request->query('q'))) {
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                    ->orWhere('email', 'like', "%{$search}%")
                    ->orWhere('category', 'like', "%{$search}%");
            });
        }

        $donations = $query->paginate(20)->withQueryString();

        return view('admin.donations.index', [
            'donations' => $donations,
            'filter' => $filter,
            'search' => $request->query('q'),
            'total' => Donation::count(),
            'recentCount' => Donation::where('created_at', '>=', now()->subDays(self::RECENT_DAYS))->count(),
            'recentDays' => self::RECENT_DAYS,
            'totalsByCurrency' => Donation::selectRaw('currency, SUM(amount) as total, COUNT(*) as count')
                ->groupBy('currency')
                ->get(),
        ]);
    }

    public function show(Donation $donation)
    {
        return view('admin.donations.show', compact('donation'));
    }

    public function toggleStatus(Donation $donation)
    {
        $donation->update([
            'status' => $donation->status === 'received' ? 'pledged' : 'received',
        ]);

        return back()->with('success', 'Donation marked as '.$donation->status.'.');
    }

    public function destroy(Donation $donation)
    {
        $donation->delete();

        return redirect()
            ->route('admin.donations.index')
            ->with('success', 'Donation deleted.');
    }
}
