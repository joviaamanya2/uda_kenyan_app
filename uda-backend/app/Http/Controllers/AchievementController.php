<?php

namespace App\Http\Controllers;

use App\Models\Achievement;
use Illuminate\Http\Request;

class AchievementController extends Controller
{
    public function index()
    {
        return Achievement::orderBy('date', 'desc')->paginate(20);
    }

    public function show(Achievement $achievement)
    {
        return $achievement;
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'title' => 'required|string',
            'description' => 'nullable|string',
            'image_path' => 'nullable|string',
            'date' => 'nullable|date',
        ]);

        $achievement = Achievement::create($data);
        return response()->json($achievement, 201);
    }

    public function update(Request $request, Achievement $achievement)
    {
        $data = $request->validate([
            'title' => 'sometimes|required|string',
            'description' => 'nullable|string',
            'image_path' => 'nullable|string',
            'date' => 'nullable|date',
        ]);

        $achievement->update($data);
        return response()->json($achievement);
    }

    public function destroy(Achievement $achievement)
    {
        $achievement->delete();
        return response()->json(null, 204);
    }
}
