import 'package:flutter/material.dart';

import '../data/quiz_categories.dart';
import '../models/category.dart';
import '../models/quiz.dart';
import '../screens/quizzes.dart';
import '../widgets/quiz/quiz_category_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    Key? key,
    required this.availableQuiz,
  }) : super(key: key);

  final List<Quiz> availableQuiz;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredQuizs = widget.availableQuiz
        .where((quiz) => quiz.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => QuizsScreen(
          title: category.title,
          quizs: filteredQuizs,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isPortrait = constraints.maxWidth < 600;

        // Sort the categories alphabetically
        final sortedCategories = quizCategories.toList()
          ..sort((a, b) => a.title.compareTo(b.title));

        return AnimatedBuilder(
          animation: _animationController,
          child: GridView(
            padding: const EdgeInsets.all(24),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isPortrait ? 2 : 4,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: [
              for (final category in sortedCategories)
                CategoryGridItem(
                  category: category,
                  onSelectCategory: () {
                    _selectCategory(context, category);
                  },
                ),
            ],
          ),
          builder: (context, child) => SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.3),
              end: const Offset(0, 0),
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
