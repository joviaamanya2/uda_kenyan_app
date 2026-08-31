<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Setting;
use Illuminate\Http\Request;

class SettingController extends Controller
{
    /**
     * The editable settings, grouped for the dashboard form.
     * key => [label, type(text|textarea|url), placeholder]
     */
    public static function schema(): array
    {
        return [
            'Contact information' => [
                'contact_phone' => ['Phone', 'text'],
                'contact_email' => ['Email', 'text'],
                'contact_address' => ['Office address', 'text'],
                'contact_hours' => ['Office hours', 'text'],
            ],
            'Social media' => [
                'social_facebook' => ['Facebook handle / URL', 'text'],
                'social_twitter' => ['Twitter / X handle', 'text'],
                'social_instagram' => ['Instagram handle', 'text'],
                'social_youtube' => ['YouTube channel URL', 'text'],
            ],
            'About the party' => [
                'about_intro' => ['Intro paragraph', 'textarea'],
                'about_vision' => ['Vision', 'textarea'],
                'about_mission' => ['Mission', 'textarea'],
                'about_values' => ['Core values', 'textarea'],
            ],
            'Live TV' => [
                'livetv_title' => ['Channel title', 'text'],
                'livetv_url' => ['Live stream / video URL', 'url'],
                'livetv_note' => ['Note shown when there is no stream', 'text'],
            ],
        ];
    }

    private static function keys(): array
    {
        return collect(static::schema())->flatMap(fn ($g) => array_keys($g))->all();
    }

    public function edit()
    {
        $schema = static::schema();
        $values = Setting::whereIn('key', static::keys())->pluck('value', 'key')->toArray();

        return view('admin.settings.edit', compact('schema', 'values'));
    }

    public function update(Request $request)
    {
        $rules = [];
        foreach (static::keys() as $key) {
            $rules[$key] = 'nullable|string|max:5000';
        }
        $data = $request->validate($rules);

        foreach (static::keys() as $key) {
            Setting::put($key, $data[$key] ?? null);
        }

        return redirect()
            ->route('admin.settings.edit')
            ->with('success', 'Settings saved.');
    }
}
