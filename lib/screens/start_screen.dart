import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:percent_indicator/percent_indicator.dart';

class StartScreen extends StatefulWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;
  Timer? timer;

  // void _startTimer() {
  //   timer = Timer.periodic(Duration(seconds: 1), (_) {
  //     setState(() {
  //       seconds--;
  //     });
  //   });
  // }

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
              //onPressed: _startTimer,
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