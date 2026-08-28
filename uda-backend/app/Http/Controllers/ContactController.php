<?php

namespace App\Http\Controllers;

use App\Models\ContactMessage;
use Illuminate\Http\Request;

class ContactController extends Controller
{
    public function index()
    {
        return ContactMessage::orderBy('created_at', 'desc')->paginate(50);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string',
            'email' => 'required|email',
            'subject' => 'nullable|string',
            'message' => 'required|string',
        ]);

        $msg = ContactMessage::create($data);
        return response()->json($msg, 201);
    }

    public function show(ContactMessage $contactMessage)
    {
        return $contactMessage;
    }

    public function markRead(ContactMessage $contactMessage)
    {
        $contactMessage->update(['read' => true]);
        return response()->json($contactMessage);
    }
}
