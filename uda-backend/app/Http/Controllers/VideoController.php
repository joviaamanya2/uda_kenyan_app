<?php

namespace App\Http\Controllers;

use App\Models\Video;
use Illuminate\Http\Request;

class VideoController extends Controller
{
    public function index()
    {
        return Video::orderByRaw('published_at IS NULL, published_at DESC')
            ->orderByDesc('id')
            ->get();
    }

    public function show(Video $video)
    {
        return $video;
    }

    public function store(Request $request)
    {
        return response()->json(Video::create($this->validated($request)), 201);
    }

    public function update(Request $request, Video $video)
    {
        $video->update($this->validated($request, sometimes: true));

        return response()->json($video);
    }

    public function destroy(Video $video)
    {
        $video->delete();

        return response()->json(null, 204);
    }

    private function validated(Request $request, bool $sometimes = false): array
    {
        $required = $sometimes ? 'sometimes|required' : 'required';

        return $request->validate([
            'title' => "{$required}|string|max:255",
            'url' => "{$required}|string|max:2048",
            'description' => 'nullable|string',
            'thumbnail_path' => 'nullable|string',
            'category' => 'nullable|string|max:255',
            'duration' => 'nullable|string|max:50',
            'published_at' => 'nullable|date',
        ]);
    }
}
