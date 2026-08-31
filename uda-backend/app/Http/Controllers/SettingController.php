<?php

namespace App\Http\Controllers;

use App\Models\Setting;

class SettingController extends Controller
{
    /** Public: all app settings (About text, contact info, Live TV, socials). */
    public function index()
    {
        return response()->json(Setting::map());
    }
}
