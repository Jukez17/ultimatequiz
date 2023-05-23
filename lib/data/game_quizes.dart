import '../models/quiz.dart';

const quizGames = [
   Quiz(
    id: 'q1',
    categories: [
      'c3',
    ],
    gameCategories: [
      'gc1'
    ],
    title: 'Dokkan Battle',
    complexity: Complexity.easy,
    imageUrl:
        'https://i.ytimg.com/vi/fi8WJXICCeo/maxresdefault.jpg',
    duration: 6,
    isEasy: true,
    isMedium: false,
    isHard: false,
    mobileGame: true,
    history: false,
    sports: false,
    realTimeStrategy: false,
  ),
  Quiz(
    id: 'q2',
    categories: [
      'c3',
    ],
    gameCategories: [
      'gc4'
    ],
    title: 'Age of Empires II: Definitive Edition',
    complexity: Complexity.medium,
    imageUrl:
        'https://pbs.twimg.com/media/FgpsxkBX0AA66-a.jpg',
    duration: 6,
    isEasy: false,
    isMedium: true,
    isHard: false,
    mobileGame: false,
    history: true,
    sports: false,
    realTimeStrategy: true,
  ),
];
