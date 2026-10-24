import 'package:flutter/material.dart';

import 'models/question_result.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({super.key, required this.results});

  final List<QuestionResult> results;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: results.map((result) {
        final color = result.isCorrect
            ? const Color(0xFF91F2D0)
            : const Color(0xFFFFB2B9);

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF202C47),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 17,
                backgroundColor: color,
                child: Text(
                  '${result.number}',
                  style: const TextStyle(
                    color: Color(0xFF11182B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.question.text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      result.isCorrect ? 'Správne' : 'Nesprávne',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tvoja odpoveď: ${result.selectedAnswer}',
                      style: TextStyle(color: color),
                    ),
                    if (!result.isCorrect) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Správna odpoveď: ${result.question.correctAnswer}',
                        style: const TextStyle(color: Color(0xFF91F2D0)),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
