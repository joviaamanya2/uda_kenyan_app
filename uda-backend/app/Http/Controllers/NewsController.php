<?php

namespace App\Http\Controllers;

use App\Models\News;
use Illuminate\Http\Request;

class NewsController extends Controller
{
    public function index()
    {
        return News::orderBy('published_at', 'desc')->paginate(20);
    }

    public function show(News $news)
    {
        return $news;
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'title' => 'required|string',
            'content' => 'required|string',
            'image_path' => 'nullable|string',
            'published_at' => 'nullable|date',
        ]);

        $news = News::create($data);
        return response()->json($news, 201);
    }

    public function update(Request $request, News $news)
    {
        $data = $request->validate([
            'title' => 'sometimes|required|string',
            'content' => 'sometimes|required|string',
            'image_path' => 'nullable|string',
            'published_at' => 'nullable|date',
        ]);

        $news->update($data);
        return response()->json($news);
    }

    public function destroy(News $news)
    {
        $news->delete();
        return response()->json(null, 204);
    }
}
