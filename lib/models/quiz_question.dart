class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;

  // Prvá odpoveď v dátach je vždy správna.
  final List<String> answers;

  String get correctAnswer => answers.first;

  List<String> getShuffledAnswers() {
    return List<String>.of(answers)..shuffle();
  }
}
