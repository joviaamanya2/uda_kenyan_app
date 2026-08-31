<?php

namespace App\Http\Controllers;

use App\Models\CommunityGroup;
use Illuminate\Http\Request;

class CommunityGroupController extends Controller
{
    public function index()
    {
        return CommunityGroup::orderBy('name')->paginate(30);
    }

    public function show(CommunityGroup $communityGroup)
    {
        return $communityGroup;
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string',
            'description' => 'nullable|string',
            'location' => 'nullable|string',
            'contact_info' => 'nullable|string',
            'whatsapp' => 'nullable|string',
        ]);

        $g = CommunityGroup::create($data);

        return response()->json($g, 201);
    }

    public function update(Request $request, CommunityGroup $communityGroup)
    {
        $data = $request->validate([
            'name' => 'sometimes|required|string',
            'description' => 'nullable|string',
            'location' => 'nullable|string',
            'contact_info' => 'nullable|string',
            'whatsapp' => 'nullable|string',
        ]);

        $communityGroup->update($data);

        return response()->json($communityGroup);
    }

    public function destroy(CommunityGroup $communityGroup)
    {
        $communityGroup->delete();

        return response()->json(null, 204);
    }
}
