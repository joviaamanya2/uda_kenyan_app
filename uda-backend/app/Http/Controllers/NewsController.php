<?php

namespace App\Http\Controllers;

use App\Models\News;
use Illuminate\Http\Request;

class NewsController extends Controller
{
    public function index(Request $request)
    {
        $query = News::orderBy('published_at', 'desc');

        $category = $request->query('category');
        if ($category && $category !== 'All') {
            $query->where('category', $category);
        }

        return $query->paginate(20);
    }

    public function show(News $news)
    {
        return $news;
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'title' => 'required|string',
            'category' => 'nullable|string',
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
            'category' => 'nullable|string',
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
