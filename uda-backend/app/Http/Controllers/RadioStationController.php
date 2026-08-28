<?php

namespace App\Http\Controllers;

use App\Models\RadioStation;
use Illuminate\Http\Request;

class RadioStationController extends Controller
{
    public function index()
    {
        return RadioStation::orderBy('name')->get();
    }

    public function show(RadioStation $radioStation)
    {
        return $radioStation;
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string',
            'stream_url' => 'nullable|string',
            'frequency' => 'nullable|string',
            'description' => 'nullable|string',
        ]);

        $s = RadioStation::create($data);
        return response()->json($s, 201);
    }

    public function update(Request $request, RadioStation $radioStation)
    {
        $data = $request->validate([
            'name' => 'sometimes|required|string',
            'stream_url' => 'nullable|string',
            'frequency' => 'nullable|string',
            'description' => 'nullable|string',
        ]);

        $radioStation->update($data);
        return response()->json($radioStation);
    }

    public function destroy(RadioStation $radioStation)
    {
        $radioStation->delete();
        return response()->json(null, 204);
    }
}
