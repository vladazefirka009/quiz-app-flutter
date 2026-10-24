# Flutter Quiz App

Interaktívny kvíz o Flutteri so šiestimi otázkami v slovenčine.

Git repozitár: https://github.com/vladazefirka009/quiz-app-flutter

## Lokálne spustenie

Projekt bol pripravený pomocou Flutter 3.47.6 / Dart 3.13.5. Potrebujete Flutter SDK; pre Android aj Android SDK, JDK a emulátor alebo zariadenie.

```sh
flutter pub get
flutter run -d chrome
```

Na Android zariadení alebo v spustenom emulátore použite `flutter run` a zvoľte Android zariadenie. iOS projekt je priložený; jeho zostavenie vyžaduje macOS a Xcode.

## Ako aplikácia funguje

1. **Start Screen** predstaví kvíz. Tlačidlo `Start Quiz` otvorí prvú otázku.
2. **Questions Screen** zobrazuje postup, aktuálnu otázku a štyri odpovede. Výber automaticky otvorí ďalšiu otázku.
3. **Results Screen** po poslednej odpovedi vypočíta skóre, percentá a zobrazí prehľad všetkých odpovedí. Nesprávne odpovede doplní správnym riešením.
4. `Restart Quiz` vynuluje odpovede a skóre a otvorí prvú otázku s novým premiešaním možností.

## Štruktúra a požiadavky zadania

```text
lib/
  data/questions.dart
  models/answer_button.dart
  models/quiz_question.dart
  models/question_result.dart
  main.dart
  quiz.dart
  start_screen.dart
  questions_screen.dart
  results_screen.dart
  questions_summary.dart
```

- `data/questions.dart`: samostatný štruktúrovaný zoznam objektov `QuizQuestion`. Prvá odpoveď v dátach je správna; používateľovi sa možnosti zobrazujú premiešané.
- `models/quiz_question.dart`: `List.of(answers)..shuffle()` premieša kópiu zoznamu. Pôvodné dáta a správna odpoveď sa nemenia.
- `quiz.dart`: `StatefulWidget` a `setState()` spravujú aktívnu obrazovku, zvolené odpovede a poradie možností. Poradie sa počas zobrazenia jednej otázky nemení. Dvojklik na starú odpoveď nepreskočí ďalšiu otázku.
- `questions_screen.dart`: tlačidlá sa vytvárajú dynamicky cez `...answers.map(...)`.
- `results_screen.dart`: `asMap().entries.map(...)` spáruje každú otázku s odpoveďou; `where(...).length` spočíta správne odpovede.
- `questions_summary.dart`: `map()` vytvára dynamický prehľad všetkých odpovedí.
- Rozhranie používa `Column`, `Row`, `Expanded`, `SingleChildScrollView` a `SafeArea`. Dlhší obsah sa posúva aj na menšom displeji.
- Aplikácia používa len Flutter SDK. Nepotrebuje účet ani sieťové služby.

## Overenie

```sh
flutter analyze
flutter test
flutter build apk --debug --no-pub
```

Automatické testy overujú zachovanie zdrojových dát pri premiešaní, celý prechod medzi obrazovkami, výsledok 6/6, reštart a následný výsledok 0/6, rozloženie pri šírke 320 px a ochranu pred dvojklikom.
