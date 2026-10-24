import '../models/quiz_question.dart';

const questions = [
  QuizQuestion('Ktorý jazyk používa Flutter?', [
    'Dart',
    'Kotlin',
    'Swift',
    'JavaScript',
  ]),
  QuizQuestion('Čo tvorí základ používateľského rozhrania vo Flutteri?', [
    'Widgety',
    'SQL tabuľky',
    'HTML súbory',
    'Git vetvy',
  ]),
  QuizQuestion('Ktorý widget má vlastný meniteľný stav?', [
    'StatefulWidget',
    'StatelessWidget',
    'SizedBox',
    'Text',
  ]),
  QuizQuestion('Ktorá metóda oznámi Flutteru zmenu stavu obrazovky?', [
    'setState()',
    'print()',
    'toString()',
    'runApp()',
  ]),
  QuizQuestion('Ktorý widget usporiada svoje deti zvislo?', [
    'Column',
    'Row',
    'Stack',
    'Center',
  ]),
  QuizQuestion('Ktorá metóda premieša poradie prvkov zoznamu?', [
    'shuffle()',
    'where()',
    'map()',
    'join()',
  ]),
];
