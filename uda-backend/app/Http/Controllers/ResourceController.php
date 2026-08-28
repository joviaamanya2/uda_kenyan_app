<?php

namespace App\Http\Controllers;

use App\Models\Resource;
use Illuminate\Http\Request;

class ResourceController extends Controller
{
    public function index()
    {
        return Resource::orderBy('published_at', 'desc')->paginate(30);
    }

    public function show(Resource $resource)
    {
        return $resource;
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'title' => 'required|string',
            'type' => 'required|string',
            'file_path' => 'nullable|string',
            'description' => 'nullable|string',
            'published_at' => 'nullable|date',
        ]);

        $r = Resource::create($data);
        return response()->json($r, 201);
    }

    public function update(Request $request, Resource $resource)
    {
        $data = $request->validate([
            'title' => 'sometimes|required|string',
            'type' => 'sometimes|required|string',
            'file_path' => 'nullable|string',
            'description' => 'nullable|string',
            'published_at' => 'nullable|date',
        ]);

        $resource->update($data);
        return response()->json($resource);
    }

    public function destroy(Resource $resource)
    {
        $resource->delete();
        return response()->json(null, 204);
    }
}
