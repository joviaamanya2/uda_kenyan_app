<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;

class ProfileController extends Controller
{
    /** Return the authenticated user's profile. */
    public function show(Request $request)
    {
        return response()->json(['user' => $request->user()]);
    }

    /**
     * Update the authenticated user's profile.
     * Accepts multipart/form-data so the avatar image can be uploaded.
     */
    public function update(Request $request)
    {
        $user = $request->user();

        $data = $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'email' => [
                'sometimes',
                'required',
                'email',
                'max:255',
                Rule::unique('users', 'email')->ignore($user->id),
            ],
            'phone' => 'nullable|string|max:30',
            'county' => 'nullable|string|max:255',
            'bio' => 'nullable|string|max:1000',
            'avatar' => 'nullable|image|max:5120',
            'remove_avatar' => 'nullable|boolean',
        ]);

        if ($request->hasFile('avatar')) {
            $this->deleteAvatar($user->avatar_path);
            $file = $request->file('avatar');
            $name = Str::random(20).'.'.$file->getClientOriginalExtension();
            $path = $file->storeAs('uploads/avatars', $name, 'public');
            $data['avatar_path'] = url('storage/'.$path);
        } elseif ($request->boolean('remove_avatar')) {
            $this->deleteAvatar($user->avatar_path);
            $data['avatar_path'] = null;
        }

        unset($data['avatar'], $data['remove_avatar']);

        $user->update($data);

        return response()->json([
            'message' => 'Profile updated.',
            'user' => $user->fresh(),
        ]);
    }

    private function deleteAvatar(?string $url): void
    {
        if (! $url) {
            return;
        }
        $pos = strpos($url, '/storage/');
        if ($pos === false) {
            return;
        }
        Storage::disk('public')->delete(substr($url, $pos + strlen('/storage/')));
    }
}
