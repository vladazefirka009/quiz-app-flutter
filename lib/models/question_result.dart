import 'quiz_question.dart';

class QuestionResult {
  const QuestionResult({
    required this.number,
    required this.question,
    required this.selectedAnswer,
  });

  final int number;
  final QuizQuestion question;
  final String selectedAnswer;

  bool get isCorrect => selectedAnswer == question.correctAnswer;
}
