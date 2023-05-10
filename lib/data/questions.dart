import '../models/quiz_question.dart';

const questions = [
  QuizQuestion(
    'How many times you can revive during the fight?',
    [
      '3',
      '1',
      '4',
      '7',
    ],
  ),
  QuizQuestion('How many dragonballs you need to gather to summon Shenron?', [
    '12',
    '4',
    '7',
    '2',
  ]),
  QuizQuestion(
    'When is global version anniversary usually held?',
    [
      'January',
      'December',
      'March',
      'July',
    ],
  ),
  QuizQuestion(
    'Which widget should you try to use more often: StatelessWidget or StatefulWidget?',
    [
      'StatelessWidget',
      'StatefulWidget',
      'Both are equally good',
      'None of the above',
    ],
  ),
  QuizQuestion(
    'What happens if you change data in a StatelessWidget?',
    [
      'The UI is not updated',
      'The UI is updated',
      'The closest StatefulWidget is updated',
      'Any nested StatefulWidgets are updated',
    ],
  ),
  QuizQuestion(
    'How should you update data inside of StatefulWidgets?',
    [
      'By calling setState()',
      'By calling updateData()',
      'By calling updateUI()',
      'By calling updateState()',
    ],
  ),
];