import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    Key? key,
    required this.answerText,
    required this.onTap,
  }) : super(key: key);

  final String answerText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        borderRadius: BorderRadius.circular(40),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: InkWell(
          onTap: onTap,
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
