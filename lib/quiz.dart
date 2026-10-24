import 'package:flutter/material.dart';

import 'data/questions.dart';
import 'questions_screen.dart';
import 'results_screen.dart';
import 'start_screen.dart';

enum QuizScreen { start, questions, results }

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  QuizScreen _screen = QuizScreen.start;
  final List<String> _selectedAnswers = [];
  List<String> _answerOptions = [];

  void _startQuiz() {
    setState(() {
      _selectedAnswers.clear();
      _answerOptions = questions.first.getShuffledAnswers();
      _screen = QuizScreen.questions;
    });
  }

  void _selectAnswer(String answer, int questionIndex) {
    if (_screen != QuizScreen.questions ||
        questionIndex != _selectedAnswers.length) {
      return;
    }

    setState(() {
      _selectedAnswers.add(answer);
      if (_selectedAnswers.length == questions.length) {
        _screen = QuizScreen.results;
      } else {
        _answerOptions = questions[_selectedAnswers.length]
            .getShuffledAnswers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionIndex = _selectedAnswers.length;
    final Widget screen = switch (_screen) {
      QuizScreen.start => StartScreen(onStart: _startQuiz),
      QuizScreen.questions => QuestionsScreen(
        question: questions[_selectedAnswers.length],
        questionNumber: _selectedAnswers.length + 1,
        totalQuestions: questions.length,
        answers: _answerOptions,
        onAnswerSelected: (answer) => _selectAnswer(answer, questionIndex),
      ),
      QuizScreen.results => ResultsScreen(
        selectedAnswers: List.unmodifiable(_selectedAnswers),
        onRestart: _startQuiz,
      ),
    };

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF24234D), Color(0xFF11182B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: screen,
            ),
          ),
        ),
      ),
    );
  }
}
