<?php

namespace App\Http\Controllers;

use App\Models\Member;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class MemberController extends Controller
{
    /**
     * Public endpoint used by the Flutter "Join UDA" form.
     * Accepts multipart/form-data so the National ID photos can be uploaded.
     */
    public function store(Request $request)
    {
        $data = $request->validate([
            'surname' => 'required|string|max:255',
            'other_name' => 'required|string|max:255',
            'phone' => 'required|string|max:30',
            'national_id_number' => 'nullable|string|max:50',
            'gender' => 'nullable|string|max:30',
            'district' => 'nullable|string|max:255',
            'village' => 'nullable|string|max:255',
            'sub_county' => 'nullable|string|max:255',
            'parish' => 'nullable|string|max:255',
            'id_front' => 'nullable|image|max:5120',
            'id_back' => 'nullable|image|max:5120',
            'was_in_uda' => 'nullable|boolean',
            'uda_from' => 'nullable|string|max:50',
            'uda_to' => 'nullable|string|max:50',
            'was_in_other_party' => 'nullable|boolean',
            'previous_party' => 'nullable|string|max:255',
        ]);

        $data['was_in_uda'] = $request->boolean('was_in_uda');
        $data['was_in_other_party'] = $request->boolean('was_in_other_party');

        foreach (['id_front' => 'id_front_path', 'id_back' => 'id_back_path'] as $input => $column) {
            if ($request->hasFile($input)) {
                $file = $request->file($input);
                $name = Str::random(20).'.'.$file->getClientOriginalExtension();
                $path = $file->storeAs('uploads/members', $name, 'public');
                $data[$column] = url('storage/'.$path);
            }
            unset($data[$input]);
        }

        $member = Member::create($data);

        return response()->json([
            'message' => 'Membership application received.',
            'member' => $member,
        ], 201);
    }
}
