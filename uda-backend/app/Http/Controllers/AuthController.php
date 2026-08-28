<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        // NOTE: validation temporarily relaxed for debugging login/register issues.
        // Blank fields are auto-filled so sign-up succeeds with an empty form.
        // Restore the stricter rules (required, email format, unique:users, min:6)
        // and drop the fallback defaults before shipping.
        $data = $request->validate([
            'name' => 'nullable',
            'email' => 'nullable',
            'password' => 'nullable',
        ]);

        $user = User::create([
            'name' => $data['name'] ?: 'Debug User',
            'email' => $data['email'] ?: 'debug+'.Str::random(8).'@uda.local',
            'password' => Hash::make($data['password'] ?: Str::random(12)),
        ]);

        $token = $this->issueToken($user);

        return response()->json(['user' => $user, 'token' => $token], 201);
    }

    public function login(Request $request)
    {
        // NOTE: validation temporarily relaxed for debugging login/register issues.
        // A blank form logs into (or creates) a shared debug account instead of
        // failing. Restore the 'required' rules and drop this fallback before shipping.
        $data = $request->validate([
            'email' => 'nullable',
            'password' => 'nullable',
        ]);

        $email = $data['email'] ?? null;
        $password = $data['password'] ?? null;

        $user = $email ? User::where('email', $email)->first() : null;
        $credentialsMatch = $user && $password && Hash::check($password, $user->password);

        if (! $credentialsMatch) {
            if (empty($email) && empty($password)) {
                $user = User::firstOrCreate(
                    ['email' => 'debug@uda.local'],
                    ['name' => 'Debug User', 'password' => Hash::make(Str::random(12))],
                );
            } else {
                return response()->json(['message' => 'Invalid credentials'], 401);
            }
        }

        $token = $this->issueToken($user);
        return response()->json(['user' => $user, 'token' => $token]);
    }

    private function issueToken(User $user): string
    {
        $token = Str::random(60);
        $user->forceFill(['api_token' => hash('sha256', $token)])->save();
        return $token;
    }
}
