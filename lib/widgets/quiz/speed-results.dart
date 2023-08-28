import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/game_quizes.dart';
import '../../models/quiz_question.dart';
import '../../questions_summary/questions_summary.dart';
import '../../screens/leaderboard_screen.dart';

class SpeedResults extends StatelessWidget {
  const SpeedResults({
    super.key,
    required this.quizTitle,
    required this.questions,
    required this.chosenAnswers,
    required this.onRestart,
    required this.totalTimeTaken,
  });

  final String quizTitle;
  final List<QuizQuestion> questions;
  final void Function() onRestart;
  final List<String> chosenAnswers;
  final double totalTimeTaken;

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].correctAnswer,
          'user_answer': chosenAnswers[i]
        },
      );
    }
    return summary;
  }

  Future<void> submitToLeaderboard(
    String userId,
    int numTotalQuestions,
    List<Map<String, Object>> summaryData,
    double totalTimeTaken,
  ) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    final numCorrectQuestions = summaryData
        .where(
          (data) => data['user_answer'] == data['correct_answer'],
        )
        .length;

    final numWrongQuestions = numTotalQuestions - numCorrectQuestions;

    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);

    final userData = await userDocRef.get();
    final username = userData['username'];

    final selectedQuiz = quizGames.firstWhere(
      (quiz) => quiz.title == quizTitle,
    );

    final leaderboardData = {
      'quiz_id': selectedQuiz.id,
      'user_id': userId,
      'username': username,
      'correct_answers': numCorrectQuestions,
      'wrong_answers': numWrongQuestions,
      'total_time': totalTimeTaken,
      'quiz_title':
          selectedQuiz.title, // Adding the quiz title to the leaderboard data
    };

    final leaderboardCollection = FirebaseFirestore.instance.collection('leaderboards');
    await leaderboardCollection.add(leaderboardData);

    await updateUserGameData(userDocRef, totalTimeTaken);

    // await FirebaseFirestore.instance
    //     .collection('leaderboards')
    //     .doc(selectedQuiz.id)
    //     .set(leaderboardData);

    // You can show a success message or navigate to a different screen here
  }

  Future<void> updateUserGameData(
      DocumentReference userDocRef, double totalTimeTaken) async {
    final userData = await userDocRef.get();
    final currentFastestTime = userData['fastest_time'];
    double parsedFastestTime =
        double.infinity; // Default value for fastest time

    if (currentFastestTime != null) {
      try {
        parsedFastestTime = double.parse(currentFastestTime);
      } catch (e) {
        // Handle parsing error, like setting a default value
      }
    }

    if (totalTimeTaken < parsedFastestTime) {
      await userDocRef.update({
        'fastest_time': totalTimeTaken,
      });
    }

    await userDocRef.update({
      'games_played': FieldValue.increment(1),
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where(
          (data) => data['user_answer'] == data['correct_answer'],
        )
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 230, 200, 253),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Total Time Taken: ${totalTimeTaken.toStringAsFixed(2)} seconds',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                await submitToLeaderboard(
                  currentUser!.uid,
                  numTotalQuestions,
                  summaryData,
                  totalTimeTaken,
                );

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LeaderboardScreen(
                      gameTitle: quizTitle,
                    ),
                  ),
                );
              },
              child: const Text('Submit Time to Leaderboard'),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Speed Quiz!'),
            )
          ],
        ),
      ),
    );
  }
}
