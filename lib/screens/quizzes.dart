import 'package:flutter/material.dart';

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
      content = ListView.builder(
        itemCount: quizs.length,
        itemBuilder: (ctx, index) => QuizItem(
          quiz: quizs[index],
          onSelectQuiz: (quiz) {
            selectQuiz(context, quiz);
          },
        ),
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