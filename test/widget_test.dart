import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/start_screen.dart';

void main() {
  test('Premiešanie zachová odpovede aj pôvodné poradie dát', () {
    for (final question in questions) {
      final original = List<String>.of(question.answers);
      final shuffled = question.getShuffledAnswers();
      expect(shuffled, unorderedEquals(original));
      expect(identical(shuffled, question.answers), isFalse);
      shuffled.removeLast();
      expect(question.answers, original);
      expect(question.correctAnswer, original.first);
    }
  });

  testWidgets('Celý kvíz, skóre 6/6, reštart a skóre 0/6 na malej obrazovke', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const QuizApp());
    expect(find.byType(StartScreen), findsOneWidget);
    await tester.ensureVisible(find.text('Start Quiz'));
    await tester.tap(find.text('Start Quiz'));
    await tester.pumpAndSettle();

    for (var attempt = 0; attempt < 2; attempt++) {
      for (var index = 0; index < questions.length; index++) {
        expect(find.byType(QuestionsScreen), findsOneWidget);
        expect(
          find.text('Otázka ${index + 1} z ${questions.length}'),
          findsOneWidget,
        );
        expect(find.text(questions[index].text), findsOneWidget);
        final answer = attempt == 0
            ? questions[index].correctAnswer
            : questions[index].answers.last;
        await tester.ensureVisible(find.text(answer));
        await tester.tap(find.text(answer));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
      expect(find.byType(ResultsScreen), findsOneWidget);
      final score = tester.widget<Text>(find.byKey(const Key('score'))).data;
      expect(score, attempt == 0 ? '6 / 6' : '0 / 6');
      expect(
        find.text(attempt == 0 ? 'Správne' : 'Nesprávne'),
        findsNWidgets(6),
      );
      if (attempt == 0) {
        await tester.ensureVisible(find.text('Restart Quiz'));
        await tester.tap(find.text('Restart Quiz'));
        await tester.pumpAndSettle();
        expect(find.text('Otázka 1 z 6'), findsOneWidget);
      }
    }
  });

  testWidgets('Dvojklik na pôvodnú odpoveď nepreskočí ďalšiu otázku', (
    tester,
  ) async {
    await tester.pumpWidget(const QuizApp());
    await tester.tap(find.text('Start Quiz'));
    await tester.pumpAndSettle();
    final answer = find.text(questions.first.correctAnswer);
    await tester.tap(answer);
    await tester.tap(answer);
    await tester.pumpAndSettle();
    expect(find.text('Otázka 2 z 6'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
