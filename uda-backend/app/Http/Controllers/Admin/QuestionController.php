<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Question;
use Illuminate\Http\Request;

class QuestionController extends Controller
{
    public function index(Request $request)
    {
        $query = Question::with('user')->latest();

        if ($request->query('filter') === 'unanswered') {
            $query->whereNull('answer_text');
        }

        $questions = $query->paginate(20)->withQueryString();
        $filter = $request->query('filter');

        return view('admin.questions.index', compact('questions', 'filter'));
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

        return back()->with('success', 'Answer saved.');
    }

    public function destroy(Question $question)
    {
        $question->delete();

        return back()->with('success', 'Question deleted.');
    }
}
