import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/quiz_question.dart';
import '../buttons/answer_button.dart';

class Questions extends StatefulWidget {
  const Questions({
    super.key,
    required this.questions,
    required this.onSelectAnswer,
  });

  final List<QuizQuestion> questions;
  final void Function(String answer) onSelectAnswer;

  @override
  State<Questions> createState() {
    return _QuestionsState();
  }
}

class _QuestionsState extends State<Questions> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    setState(() {
      currentQuestionIndex++; // increments the value by 1
    });
  }

  @override
  Widget build(context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

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

    return isLandscape
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    currentQuestion.text,
                    style: GoogleFonts.lato(
                      color: const Color.fromARGB(255, 201, 153, 251),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: currentQuestion.shuffledAnswers.map((answer) {
                      return AnswerButton(
                        answerText: answer,
                        onTap: () {
                          answerQuestion(answer);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          )
        : Center(
          child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    margin: const EdgeInsets.all(10),
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
                        ...currentQuestion.shuffledAnswers.map((answer) {
                          return AnswerButton(
                            answerText: answer,
                            onTap: () {
                              answerQuestion(answer);
                            },
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ],
            ),
        );
  }
}
