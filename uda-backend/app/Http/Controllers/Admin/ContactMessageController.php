<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\ContactMessage;
use Illuminate\Http\Request;

class ContactMessageController extends Controller
{
    public function index(Request $request)
    {
        $query = ContactMessage::latest();

        if ($request->query('filter') === 'unread') {
            $query->where('read', false);
        }

        $messages = $query->paginate(20)->withQueryString();
        $filter = $request->query('filter');

        return view('admin.messages.index', compact('messages', 'filter'));
    }

    public function toggleRead(ContactMessage $message)
    {
        $message->update(['read' => ! $message->read]);

        return back()->with('success', 'Message marked as '.($message->read ? 'read' : 'unread').'.');
    }

    public function destroy(ContactMessage $message)
    {
        $message->delete();

        return back()->with('success', 'Message deleted.');
    }
}
