<?php

namespace App\Http\Controllers;

use App\Models\GalleryItem;
use Illuminate\Http\Request;

class GalleryController extends Controller
{
    public function index()
    {
        return GalleryItem::orderBy('id', 'desc')->paginate(40);
    }

    public function show(GalleryItem $galleryItem)
    {
        return $galleryItem;
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'title' => 'nullable|string',
            'type' => 'required|string',
            'path' => 'required|string',
            'caption' => 'nullable|string',
        ]);

        $g = GalleryItem::create($data);
        return response()->json($g, 201);
    }

    public function update(Request $request, GalleryItem $galleryItem)
    {
        $data = $request->validate([
            'title' => 'nullable|string',
            'type' => 'nullable|string',
            'path' => 'nullable|string',
            'caption' => 'nullable|string',
        ]);

        $galleryItem->update($data);
        return response()->json($galleryItem);
    }

    public function destroy(GalleryItem $galleryItem)
    {
        $galleryItem->delete();
        return response()->json(null, 204);
    }
}
