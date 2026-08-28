<?php

namespace App\Http\Controllers;

use App\Models\TVStation;
use Illuminate\Http\Request;

class TVStationController extends Controller
{
    public function index()
    {
        return TVStation::orderBy('name')->get();
    }

    public function show(TVStation $tVStation)
    {
        return $tVStation;
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string',
            'stream_url' => 'nullable|string',
            'description' => 'nullable|string',
        ]);

        $s = TVStation::create($data);
        return response()->json($s, 201);
    }

    public function update(Request $request, TVStation $tVStation)
    {
        $data = $request->validate([
            'name' => 'sometimes|required|string',
            'stream_url' => 'nullable|string',
            'description' => 'nullable|string',
        ]);

        $tVStation->update($data);
        return response()->json($tVStation);
    }

    public function destroy(TVStation $tVStation)
    {
        $tVStation->delete();
        return response()->json(null, 204);
    }
}
