import 'package:flutter/material.dart';

import '../data/questions.dart';
import '../models/quiz.dart';
import '../models/quiz_question.dart';
import '../widgets/start_button.dart';
import '../widgets/questions.dart';
import '../widgets/results.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.quizId,
    required this.quiz,
  });

  final Quiz quiz;
  final String quizId;

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

  List<QuizQuestion> getQuizQuestionsById(String quizId) {
    // Replace this with your implementation to fetch the quiz questions based on the quiz ID
    // Example implementation:
    List<QuizQuestion> questions = [];

    if (quizId == 'q1') {
      questions = dokkanEasy;
    } else if (quizId == 'q2') {
      questions = aoeMedium;
    }

    return questions;
  }

  void _chooseAnswer(String answer) {
    _selectedAnswers.add(answer);

    // Get the quiz questions based on the quiz ID
    List<QuizQuestion> questions = getQuizQuestionsById(widget.quizId);

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
        questions: getQuizQuestionsById(widget.quizId),
        onSelectAnswer: _chooseAnswer,
      );
    }

    if (_activeWidget == 'results') {
      screenWidget = Results(
        questions: getQuizQuestionsById(widget.quizId),
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
