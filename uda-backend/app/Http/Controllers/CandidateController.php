<?php

namespace App\Http\Controllers;

use App\Models\Candidate;
use Illuminate\Http\Request;

class CandidateController extends Controller
{
    public function index()
    {
        return Candidate::orderBy('name')->paginate(30);
    }

    public function show(Candidate $candidate)
    {
        return $candidate;
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string',
            'position' => 'nullable|string',
            'constituency' => 'nullable|string',
            'party' => 'nullable|string',
            'bio' => 'nullable|string',
            'photo_path' => 'nullable|string',
            'is_elected' => 'nullable|boolean',
        ]);

        $candidate = Candidate::create($data);
        return response()->json($candidate, 201);
    }

    public function update(Request $request, Candidate $candidate)
    {
        $data = $request->validate([
            'name' => 'sometimes|required|string',
            'position' => 'nullable|string',
            'constituency' => 'nullable|string',
            'party' => 'nullable|string',
            'bio' => 'nullable|string',
            'photo_path' => 'nullable|string',
            'is_elected' => 'nullable|boolean',
        ]);

        $candidate->update($data);
        return response()->json($candidate);
    }

    public function destroy(Candidate $candidate)
    {
        $candidate->delete();
        return response()->json(null, 204);
    }
}
