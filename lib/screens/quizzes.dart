import 'package:flutter/material.dart';
import 'package:ultimatequiz/data/game_categories.dart';

import '../models/quiz.dart';
import '../screens/quiz.dart';
import '../widgets/quiz_item.dart';

class QuizsScreen extends StatelessWidget {
  const QuizsScreen({
    super.key,
    this.title,
    required this.quizs,
  });

  final String? title;
  final List<Quiz> quizs;

  void selectQuiz(BuildContext context, Quiz quiz) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => QuizScreen(
          quizId: quiz.id,
          quiz: quiz,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (quizs.isNotEmpty) {
      content = Column(
        children: [
          SizedBox(
            height: 80, // Adjust the height as desired
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: gameCategories.length,
              itemBuilder: (ctx, index) => GestureDetector(
                onTap: () {
                  selectQuiz(context, quizs[index]);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Center(
                        child: Text(
                          gameCategories[index].title,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: quizs.length,
              itemBuilder: (ctx, index) => QuizItem(
                quiz: quizs[index],
                onSelectQuiz: (quiz) {
                  selectQuiz(context, quiz);
                },
              ),
            ),
          ),
        ],
      );
    }

    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
