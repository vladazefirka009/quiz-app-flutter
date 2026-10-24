import 'package:flutter/material.dart';

import 'data/questions.dart';
import 'models/question_result.dart';
import 'questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.selectedAnswers,
    required this.onRestart,
  });

  final List<String> selectedAnswers;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    final results = questions.asMap().entries.map((entry) {
      return QuestionResult(
        number: entry.key + 1,
        question: entry.value,
        selectedAnswer: selectedAnswers[entry.key],
      );
    }).toList();
    final correctCount = results.where((result) => result.isCorrect).length;
    final percentage = (correctCount / questions.length * 100).round();
    final accent = Theme.of(context).colorScheme.primary;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Tvoje výsledky',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF303354),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Icon(Icons.emoji_events_outlined, size: 44, color: accent),
                const SizedBox(height: 8),
                Text(
                  '$correctCount / ${questions.length}',
                  key: const Key('score'),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
                Text(
                  '$percentage % správnych odpovedí',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                Text(
                  correctCount == questions.length
                      ? 'Výborne! Máš všetko správne.'
                      : 'Každý pokus ťa posunie ďalej.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: onRestart,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Restart Quiz'),
          ),
          const SizedBox(height: 28),
          const Text(
            'Prehľad odpovedí',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          QuestionsSummary(results: results),
        ],
      ),
    );
  }
}
