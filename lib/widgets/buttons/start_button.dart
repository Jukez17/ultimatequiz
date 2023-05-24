import 'package:flutter/material.dart';
class StartQuizButton extends StatefulWidget {
  const StartQuizButton(this.startQuiz, this.startSpeedQuiz, {super.key});

  final void Function() startQuiz;
  final void Function() startSpeedQuiz;

  @override
  State<StartQuizButton> createState() => _StartQuizButtonState();
}

class _StartQuizButtonState extends State<StartQuizButton>
 with TickerProviderStateMixin {

  @override
  Widget build(context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isLandscape)
            const SizedBox(height: 80),
          SizedBox(
            width: 200.0,
            height: 60.0,
            child: OutlinedButton.icon(
              onPressed: widget.startQuiz,
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white, alignment: Alignment.center),
              icon: const Icon(Icons.arrow_right_alt),
              label: const Text('Start Quiz'),
            ),
          ),
          const SizedBox(height: 80),
          SizedBox(
            width: 200.0,
            height: 60.0,
            child: OutlinedButton.icon(
              onPressed: widget.startSpeedQuiz,
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white, alignment: Alignment.center),
              icon: const Icon(Icons.arrow_right_alt),
              label: const Text('Start Speed Quiz'),
            ),
          ),
        ],
      ),
    );
  }
}
