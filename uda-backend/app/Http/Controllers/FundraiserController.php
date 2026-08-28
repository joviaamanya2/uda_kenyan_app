<?php

namespace App\Http\Controllers;

use App\Models\Fundraiser;
use Illuminate\Http\Request;

class FundraiserController extends Controller
{
    public function index()
    {
        return Fundraiser::orderBy('start_date', 'desc')->paginate(20);
    }

    public function show(Fundraiser $fundraiser)
    {
        return $fundraiser;
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'title' => 'required|string',
            'description' => 'nullable|string',
            'goal_amount' => 'nullable|numeric',
            'raised_amount' => 'nullable|numeric',
            'image_path' => 'nullable|string',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
        ]);

        $f = Fundraiser::create($data);
        return response()->json($f, 201);
    }

    public function update(Request $request, Fundraiser $fundraiser)
    {
        $data = $request->validate([
            'title' => 'sometimes|required|string',
            'description' => 'nullable|string',
            'goal_amount' => 'nullable|numeric',
            'raised_amount' => 'nullable|numeric',
            'image_path' => 'nullable|string',
            'start_date' => 'nullable|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
        ]);

        $fundraiser->update($data);
        return response()->json($fundraiser);
    }

    public function destroy(Fundraiser $fundraiser)
    {
        $fundraiser->delete();
        return response()->json(null, 204);
    }
}
