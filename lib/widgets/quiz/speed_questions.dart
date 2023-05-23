import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/quiz_question.dart';
import '../buttons/speed_answer_button.dart';
import '../timers/question_timer.dart';

class SpeedQuestions extends StatefulWidget {
  const SpeedQuestions({
    Key? key,
    required this.questions,
    required this.onSelectAnswer,
  }) : super(key: key);

  final List<QuizQuestion> questions;
  final void Function(String answer) onSelectAnswer;

  @override
  State<SpeedQuestions> createState() {
    return _SpeedQuestionsState();
  }
}

class _SpeedQuestionsState extends State<SpeedQuestions>
    with TickerProviderStateMixin {
  var currentQuestionIndex = 0;
  //late QuizTimer _quizTimer;
  late AnimationController _animationController;
  var _seconds = 10;
  bool isTimerFinished = false;

  @override
  void initState() {
    super.initState();
    isTimerFinished = false;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: _seconds),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && !isTimerFinished) {
        // Handle timer finished event if needed
        setState(() {
          isTimerFinished = true;
        });
        // Call a function or perform any action you need
      }
    });

    resetTimer();
  }

  void resetTimer() {
    setState(() {
      _seconds = 10;
      isTimerFinished = false;
    });

    _animationController.reset();
    _animationController.duration = Duration(seconds: _seconds);
    _animationController.reverse(from: 1.0);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++; // increments the value by 1
    });
    resetTimer();
  }

  @override
  Widget build(context) {
    if (currentQuestionIndex >= widget.questions.length) {
      // If the current question index exceeds the number of available questions,
      // display a different widget or handle the situation accordingly.
      return const Center(
        child: Text(
          'No more questions',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    final currentQuestion = widget.questions[currentQuestionIndex];

    return Column(
      children: [
        QuizTimer(
          duration: Duration(seconds: _seconds),
          animationController: _animationController,
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  currentQuestion.text,
                  style: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 201, 153, 251),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ...currentQuestion.shuffledAnswers.map(
                  (answer) {
                    return SpeedAnswerButton(
                      answerText: answer,
                      onTap: () {
                        answerQuestion(answer);
                      },
                      isTimerRunning: !isTimerFinished,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
