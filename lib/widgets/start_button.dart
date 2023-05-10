import 'package:flutter/material.dart';

class StartQuizButton extends StatefulWidget {
  const StartQuizButton(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  State<StartQuizButton> createState() => _StartQuizButtonState();
}

class _StartQuizButtonState extends State<StartQuizButton> {

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 80),
          SizedBox(
            width: 200.0,
            height: 60.0,
            child: OutlinedButton.icon(
              onPressed: widget.startQuiz,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                alignment: Alignment.center
              ),
              icon: const Icon(Icons.arrow_right_alt),
              label: const Text('Start Quiz'),
            ),
          )
        ],
      ),
    );
  }
}