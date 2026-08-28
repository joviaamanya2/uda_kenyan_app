<?php

namespace App\Http\Controllers;

use App\Models\Question;
use Illuminate\Http\Request;

class QuestionController extends Controller
{
    public function index()
    {
        return Question::orderBy('created_at', 'desc')->paginate(30);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'user_id' => 'nullable|integer',
            'question_text' => 'required|string',
        ]);

        $q = Question::create($data);
        return response()->json($q, 201);
    }

    public function answer(Request $request, Question $question)
    {
        $data = $request->validate([
            'answer_text' => 'required|string',
        ]);

        $question->update([
            'answer_text' => $data['answer_text'],
            'answered_at' => now(),
        ]);

        return response()->json($question);
    }
}
