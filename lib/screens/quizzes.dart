import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/game_categories.dart';
import '../models/quiz.dart';
import '../providers/guiz_filters_provider.dart';
import '../screens/quiz.dart';
import '../widgets/quiz/quiz_item.dart';

class QuizsScreen extends ConsumerWidget {
  const QuizsScreen({
    Key? key,
    this.title,
    required this.quizs,
  }) : super(key: key);

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
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    final List<Quiz> filteredQuizs = ref.watch(filteredQuizProvider);

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
      content = OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: double.infinity, // Adjust the height as desired
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: gameCategories.length,
                      itemBuilder: (ctx, index) {
                        final isActive =
                            activeFilters[Filter.values[index]] ?? false;
                        final category = gameCategories[index];

                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(filtersProvider.notifier)
                                .setFilter(Filter.values[index], !isActive);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(filtersProvider.notifier)
                                    .setFilter(Filter.values[index], !isActive);
                              },
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(2),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                                    if (isActive) {
                                      return category.color.withOpacity(0.8);
                                    } else if (states
                                        .contains(MaterialState.hovered)) {
                                      return category.color.withOpacity(0.2);
                                    } else {
                                      return Theme.of(context)
                                          .colorScheme
                                          .primaryContainer;
                                    }
                                  },
                                ),
                              ),
                              child: Text(
                                category.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                    itemCount: filteredQuizs.length,
                    itemBuilder: (ctx, index) => QuizItem(
                      quiz: filteredQuizs[index],
                      onSelectQuiz: (quiz) {
                        selectQuiz(context, quiz);
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  height: 80, // Adjust the height as desired
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: gameCategories.length,
                    itemBuilder: (ctx, index) {
                      final isActive =
                          activeFilters[Filter.values[index]] ?? false;
                      final category = gameCategories[index];

                      return GestureDetector(
                        onTap: () {
                          ref
                              .read(filtersProvider.notifier)
                              .setFilter(Filter.values[index], !isActive);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(filtersProvider.notifier)
                                  .setFilter(Filter.values[index], !isActive);
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(2),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (states) {
                                  if (isActive) {
                                    return category.color.withOpacity(0.8);
                                  } else if (states
                                      .contains(MaterialState.hovered)) {
                                    return category.color.withOpacity(0.2);
                                  } else {
                                    return Theme.of(context)
                                        .colorScheme
                                        .primaryContainer;
                                  }
                                },
                              ),
                            ),
                            child: Text(
                              category.title,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredQuizs.length,
                    itemBuilder: (ctx, index) => QuizItem(
                      quiz: filteredQuizs[index],
                      onSelectQuiz: (quiz) {
                        selectQuiz(context, quiz);
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
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
