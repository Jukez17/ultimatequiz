import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameLeaderboard extends StatelessWidget {
  final String gameTitle;

  const GameLeaderboard({
    super.key,
    required this.gameTitle,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('leaderboards')
          .where('quiz_title', isEqualTo: gameTitle)
          .orderBy('correct_answers', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Loading indicator while data is being fetched
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No leaderboard data available.');
        }

        final leaderboardData = snapshot.data!.docs;

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: leaderboardData.length,
                itemBuilder: (context, index) {
                  final entry = leaderboardData[index].data();
                  final username = entry['username'];
                  final correctAnswers = entry['correct_answers'];
                  final totalQuestions =
                      correctAnswers + entry['wrong_answers'];
                  final totalTime = entry['total_time'];

                  return Card(
                    elevation: 2.0,
                    child: ListTile(
                      title: Text(
                        username,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Correct Answers: $correctAnswers / $totalQuestions',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Time Taken: ${totalTime.toStringAsFixed(2)} seconds',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
