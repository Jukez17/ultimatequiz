import 'package:flutter/material.dart';

import '../data/questions.dart';
import '../models/quiz.dart';
import '../models/quiz_question.dart';
import '../widgets/buttons/start_button.dart';
// Normal mode
import '../widgets/quiz/questions.dart';
import '../widgets/quiz/results.dart';
// Speed mode
import '../widgets/quiz/speed_questions.dart';
import '../widgets/quiz/speed-results.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    Key? key,
    required this.quizId,
    required this.quiz,
  }) : super(key: key);

  final Quiz quiz;
  final String quizId;

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<String> _selectedAnswers = [];
  var _activeWidget = 'start-quiz';
  double totalTimeTaken = 0.0;

  void _switchScreen() {
    setState(() {
      _activeWidget = 'questions';
    });
  }

  void _switchToSpeedQuiz() {
    setState(() {
      _activeWidget = 'speed-questions';
      totalTimeTaken = 0; // Reset the total time taken for the speed quiz
    });
  }

  List<QuizQuestion> getQuizQuestionsById(String quizId) {
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
        if (_activeWidget == 'speed-questions') {
          _activeWidget = 'speed-results';
        }
        if (_activeWidget == 'questions') {
          _activeWidget = 'results';
        }
      });
    }
  }

  void _chooseSpeedAnswer(String answer, double timeTaken) {
    _selectedAnswers.add(answer);

    // Get the quiz questions based on the quiz ID
    List<QuizQuestion> questions = getQuizQuestionsById(widget.quizId);

    if (_selectedAnswers.length == questions.length) {
      setState(() {
        _activeWidget = 'speed-results';
        totalTimeTaken += timeTaken;
      });
    }
  }

  void restartQuiz() {
    setState(() {
      _activeWidget = 'questions';
    });
  }

  void restartSpeedQuiz() {
    setState(() {
      _activeWidget = 'speed-questions';
      totalTimeTaken = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

    Widget screenWidget = StartQuizButton(_switchScreen, _switchToSpeedQuiz);

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

    if (_activeWidget == 'speed-questions') {
      screenWidget = SpeedQuestions(
        questions: getQuizQuestionsById(widget.quizId),
        onSelectAnswer: _chooseSpeedAnswer,
        selectedAnswers: _selectedAnswers,
      );
    }

    if (_activeWidget == 'speed-results') {
      screenWidget = SpeedResults(
        quizTitle: widget.quiz.title,
        questions: getQuizQuestionsById(widget.quizId),
        chosenAnswers: _selectedAnswers,
        onRestart: restartSpeedQuiz,
        totalTimeTaken: totalTimeTaken,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
      ),
      body: isLandscape
          ? Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: screenWidget,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: screenWidget,
                  ),
                ],
              ),
            ),
    );
  }
}
