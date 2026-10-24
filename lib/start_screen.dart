import 'package:flutter/material.dart';

import 'data/questions.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final accent = Theme.of(context).colorScheme.primary;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: const Color(0xFF39365E),
              borderRadius: BorderRadius.circular(36),
            ),
            child: Icon(Icons.psychology_alt_outlined, size: 80, color: accent),
          ),
          const SizedBox(height: 32),
          Text(
            'FLUTTER KVÍZ',
            style: TextStyle(
              color: accent,
              letterSpacing: 3,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Koľko toho vieš\no Flutteri?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Vyber vždy jednu odpoveď. Na konci uvidíš svoje skóre aj správne riešenia.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              height: 1.5,
              color: Color(0xFFC6CEE1),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '${questions.length} otázok · bez časového limitu',
            style: TextStyle(color: accent),
          ),
          const SizedBox(height: 32),
          FilledButton.icon(
            onPressed: onStart,
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}
