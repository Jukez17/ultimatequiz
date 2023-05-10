import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/questions.dart';
import '../models/quiz.dart';
import '../providers/favorites_provider.dart';
import 'start_screen.dart';
import 'questions_screen.dart';
import 'results_screen.dart';

class QuizScreen extends ConsumerWidget {
  const QuizScreen({
    super.key,
    required this.quiz,
  });

  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteQuiz = ref.watch(favoriteQuizProvider);
    final isFavorite = favoriteQuiz.contains(quiz);
    List<String> _selectedAnswers = [];
    var _activeWidget = 'start-quiz';

      void _switchScreen() {
      _activeWidget = 'questions';
  }

  Widget screenWidget = StartScreen(_switchScreen);

//   void _chooseAnswer(String answer) {
//     _selectedAnswers.add(answer);

//     if (_selectedAnswers.length == questions.length) {
//       setState(() {
//         _activeScreen = 'results-screen';
//       });
//     }
//   }

//   void restartQuiz() {
//     setState(() {
//       _activeScreen = 'questions-screen';
//     });
//   }

    return Scaffold(
      appBar: AppBar(title: Text(quiz.title), actions: [
        IconButton(
          onPressed: () {
            final wasAdded = ref
                .read(favoriteQuizProvider.notifier)
                .toggleQuizFavoriteStatus(quiz);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  wasAdded
                      ? 'Quiz added as a favorite.'
                      : 'Quiz removed from favorites.',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return RotationTransition(
                turns: Tween<double>(begin: 0.8, end: 1).animate(animation),
                child: child,
              );
            },
            child: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              key: ValueKey(isFavorite),
            ),
          ),
        )
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: quiz.id,
              child: Image.network(
                quiz.imageUrl,
                height: 210,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14),
            screenWidget,
          ],
        ),
      ),
    );
  }
}

//   @override
//   State<QuizScreen> createState() {
//     return _QuizScreenState();
//   }
// }

// class _QuizScreenState extends State<QuizScreen> {
//   List<String> _selectedAnswers = [];
//   var _activeScreen = 'start-screen';

//   void _switchScreen() {
//     setState(() {
//       _activeScreen = 'questions-screen';
//     });
//   }

//   void _chooseAnswer(String answer) {
//     _selectedAnswers.add(answer);

//     if (_selectedAnswers.length == questions.length) {
//       setState(() {
//         _activeScreen = 'results-screen';
//       });
//     }
//   }

//   void restartQuiz() {
//     setState(() {
//       _activeScreen = 'questions-screen';
//     });
//   }

//   @override
//   Widget build(context) {
//     Widget screenWidget = StartScreen(_switchScreen);

//     if (_activeScreen == 'questions-screen') {
//       screenWidget = QuestionsScreen(
//         onSelectAnswer: _chooseAnswer,
//       );
//     }

//     if (_activeScreen == 'results-screen') {
//       screenWidget = ResultsScreen(
//         chosenAnswers: _selectedAnswers,
//         onRestart: restartQuiz,
//       );
//     }

//     return MaterialApp(
//       home: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color.fromARGB(255, 78, 13, 151),
//                 Color.fromARGB(255, 107, 15, 168),
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: screenWidget,
//         ),
//       ),
//     );
//   }
// }