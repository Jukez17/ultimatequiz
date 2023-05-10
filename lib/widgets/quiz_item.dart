import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/quiz.dart';
import '../widgets/quiz_item_trait.dart';

class QuizItem extends StatelessWidget {
  const QuizItem({
    super.key,
    required this.quiz,
    required this.onSelectQuiz,
  });

  final Quiz quiz;
  final void Function(Quiz quiz) onSelectQuiz;

  String get complexityText {
    return quiz.complexity.name[0].toUpperCase() +
        quiz.complexity.name.substring(1);
  }

 @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onSelectQuiz(quiz);
        },
        child: Stack(
          children: [
            Hero(
              tag: quiz.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(quiz.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      quiz.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, // Very long text ...
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 12),
                        QuizItemTrait(
                          icon: Icons.castle_sharp,
                          label: complexityText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
