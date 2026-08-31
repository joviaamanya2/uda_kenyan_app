<?php

namespace App\Http\Controllers\Admin;

use App\Admin\ResourceRegistry;
use App\Http\Controllers\Controller;
use App\Models\ContactMessage;
use App\Models\Donation;
use App\Models\Member;
use App\Models\Question;
use App\Models\User;

class DashboardController extends Controller
{
    public function index()
    {
        $counts = [];
        foreach (ResourceRegistry::all() as $key => $config) {
            $counts[$key] = [
                'label' => $config['plural'],
                'total' => $config['model']::count(),
            ];
        }

        $stats = [
            'app_users' => User::count(),
            'unread_messages' => ContactMessage::where('read', false)->count(),
            'total_messages' => ContactMessage::count(),
            'unanswered_questions' => Question::whereNull('answer_text')->count(),
            'total_questions' => Question::count(),
            'total_members' => Member::count(),
            'recent_members' => Member::where('created_at', '>=', now()->subDays(7))->count(),
            'total_donations' => Donation::count(),
            'donations_raised' => Donation::selectRaw('currency, SUM(amount) as total')
                ->groupBy('currency')
                ->pluck('total', 'currency'),
        ];

        $recentMessages = ContactMessage::latest()->take(5)->get();
        $recentQuestions = Question::with('user')->latest()->take(5)->get();

        // --- Users per month (last 6 months, oldest first) ---
        $usersMonthly = ['labels' => [], 'data' => []];
        for ($i = 5; $i >= 0; $i--) {
            $month = now()->subMonths($i)->startOfMonth();
            $usersMonthly['labels'][] = $month->format('M Y');
            $usersMonthly['data'][] = User::whereBetween('created_at', [
                $month, (clone $month)->endOfMonth(),
            ])->count();
        }

        // --- Donations by category (for the pie) ---
        $donationsByCategory = Donation::selectRaw(
            "COALESCE(NULLIF(category, ''), 'General') as cat, SUM(amount) as total, COUNT(*) as cnt"
        )->groupBy('cat')->orderByDesc('total')->get();

        $donationsPie = [
            'labels' => $donationsByCategory->pluck('cat'),
            'data' => $donationsByCategory->pluck('total')->map(fn ($v) => round((float) $v, 2)),
            'counts' => $donationsByCategory->pluck('cnt'),
        ];

        return view('admin.dashboard', compact(
            'counts', 'stats', 'recentMessages', 'recentQuestions',
            'usersMonthly', 'donationsPie',
        ));
    }
}
