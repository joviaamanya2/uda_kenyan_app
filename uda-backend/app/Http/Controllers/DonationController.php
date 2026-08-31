<?php

namespace App\Http\Controllers;

use App\Models\Donation;
use Illuminate\Http\Request;

class DonationController extends Controller
{
    /**
     * Public endpoint used by the Flutter "Fundraise / Donate" form.
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'category' => 'nullable|string|max:255',
            'amount' => 'required|numeric|min:1',
            'currency' => 'nullable|string|max:8',
            'location' => 'nullable|string|max:255',
            'comment' => 'nullable|string',
        ]);

        $data['currency'] = strtoupper($data['currency'] ?? 'USD');

        $donation = Donation::create($data);

        return response()->json([
            'message' => 'Thank you! Your donation has been recorded.',
            'donation' => $donation,
        ], 201);
    }
}
