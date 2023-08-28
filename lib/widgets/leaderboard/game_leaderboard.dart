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
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No leaderboard data available.');
        }

        final leaderboardData = snapshot.data!.docs;

        // Sort the leaderboard data by total time in ascending order
        final sortedLeaderboardData = [...leaderboardData];
        sortedLeaderboardData.sort((a, b) {
          final timeA = a['total_time'];
          final timeB = b['total_time'];
          return timeA.compareTo(timeB);
        });

        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: sortedLeaderboardData.length,
                itemBuilder: (context, index) {
                  final entry = sortedLeaderboardData[index];
                  final username = entry['username'];
                  final correctAnswers = entry['correct_answers'];
                  final totalQuestions =
                      correctAnswers + entry['wrong_answers'];
                  final totalTime = entry['total_time'];

                  // Determine the trophy emoji and color based on ranking
                  IconData trophyIcon;
                  Color trophyColor;
                  if (index == 0) {
                    trophyIcon = Icons.emoji_events;
                    trophyColor = Colors.yellow; // Gold Trophy
                  } else if (index == 1) {
                    trophyIcon = Icons.emoji_events;
                    trophyColor = Colors.grey; // Silver Trophy
                  } else if (index == 2) {
                    trophyIcon = Icons.emoji_events;
                    trophyColor = Colors.brown; // Bronze Trophy
                  } else {
                    trophyIcon =
                        Icons.emoji_events; // No Trophy for other ranks
                    trophyColor = Colors.transparent; // No color
                  }

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
                      trailing: Icon(
                        trophyIcon,
                        color: trophyColor,
                        size: 40.0, // Customize trophy color
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
