import 'package:flutter/material.dart';

import '../data/questions.dart';
import '../models/quiz.dart';
import '../widgets/start_button.dart';
import '../widgets/questions.dart';
import '../widgets/results.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.quiz,
  });

  final Quiz quiz;

  @override
  State<QuizScreen> createState() {
    return _QuizScreenState();
  }
}

class _QuizScreenState extends State<QuizScreen> {
  List<String> _selectedAnswers = [];
  var _activeWidget = 'start-quiz';

  void _switchScreen() {
    setState(() {
      _activeWidget = 'questions';
    });
  }

  void _chooseAnswer(String answer) {
    _selectedAnswers.add(answer);

    if (_selectedAnswers.length == questions.length) {
      setState(() {
        _activeWidget = 'results';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      _activeWidget = 'questions';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartQuizButton(_switchScreen);

    if (_activeWidget == 'questions') {
      screenWidget = Questions(
        onSelectAnswer: _chooseAnswer,
      );
    }

    if (_activeWidget == 'results') {
      screenWidget = Results(
        chosenAnswers: _selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.quiz.id,
              child: Image.network(
                widget.quiz.imageUrl,
                height: 210,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            screenWidget,
          ],
        ),
      ),
    );
  }
}