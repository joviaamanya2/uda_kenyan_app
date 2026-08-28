<?php

namespace App\Http\Controllers;

use App\Models\Leader;
use Illuminate\Http\Request;

class LeaderController extends Controller
{
    public function index(Request $request)
    {
        $query = Leader::orderBy('sort_order')->orderBy('name');

        if ($request->filled('category')) {
            $query->where('category', $request->query('category'));
        }

        return $query->get();
    }

    public function show(Leader $leader)
    {
        return $leader;
    }

    public function store(Request $request)
    {
        $data = $request->validate($this->rules());
        $leader = Leader::create($data);
        return response()->json($leader, 201);
    }

    public function update(Request $request, Leader $leader)
    {
        $data = $request->validate($this->rules(sometimes: true));
        $leader->update($data);
        return response()->json($leader);
    }

    public function destroy(Leader $leader)
    {
        $leader->delete();
        return response()->json(null, 204);
    }

    private function rules(bool $sometimes = false): array
    {
        $required = $sometimes ? 'sometimes|required' : 'required';

        return [
            'name' => "{$required}|string",
            'category' => 'nullable|string',
            'section' => 'nullable|string',
            'position' => 'nullable|string',
            'county' => 'nullable|string',
            'constituency' => 'nullable|string',
            'bio' => 'nullable|string',
            'office' => 'nullable|string',
            'email' => 'nullable|email',
            'phone' => 'nullable|string',
            'term_label' => 'nullable|string',
            'photo_path' => 'nullable|string',
            'is_featured' => 'nullable|boolean',
            'sort_order' => 'nullable|integer',
        ];
    }
}
