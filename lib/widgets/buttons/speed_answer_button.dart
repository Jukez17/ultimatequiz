import 'package:flutter/material.dart';

class SpeedAnswerButton extends StatelessWidget {
  const SpeedAnswerButton({
    Key? key,
    required this.answerText,
    required this.onTap,
    required this.isTimerRunning,
  }) : super(key: key);

  final String answerText;
  final VoidCallback onTap;
  final bool isTimerRunning;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        borderRadius: BorderRadius.circular(40),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: InkWell(
          onTap: isTimerRunning ? null : onTap,
          borderRadius: BorderRadius.circular(40),
          child: Ink(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 40,
            ),
            child: Text(
              answerText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
