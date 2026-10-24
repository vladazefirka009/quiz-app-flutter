import 'package:flutter/material.dart';

import 'models/answer_button.dart';
import 'models/quiz_question.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
    required this.answers,
    required this.onAnswerSelected,
  });

  final QuizQuestion question;
  final int questionNumber;
  final int totalQuestions;
  final List<String> answers;
  final ValueChanged<String> onAnswerSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.quiz_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('FLUTTER KVÍZ', style: TextStyle(letterSpacing: 2)),
              ),
              Text('$questionNumber / $totalQuestions'),
            ],
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: questionNumber / totalQuestions,
            minHeight: 6,
            borderRadius: BorderRadius.circular(8),
            backgroundColor: const Color(0xFF39405E),
          ),
          const SizedBox(height: 36),
          Text(
            'Otázka $questionNumber z $totalQuestions',
            style: const TextStyle(color: Color(0xFFC6CEE1)),
          ),
          const SizedBox(height: 12),
          Text(
            question.text,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 28),
          ...answers.map(
            (answer) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AnswerButton(
                answer: answer,
                onTap: () => onAnswerSelected(answer),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Po výbere pokračuješ na ďalšiu otázku.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFFC6CEE1)),
          ),
        ],
      ),
    );
  }
}
