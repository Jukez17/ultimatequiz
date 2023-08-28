import 'package:flutter/material.dart';

import '../models/quiz.dart';
import '../widgets/leaderboard/leaderboards_item.dart';

class LeaderboardsScreen extends StatelessWidget {
  final List<Quiz> filteredQuizs; // Make sure you have this list

  const LeaderboardsScreen({
    super.key,
    required this.filteredQuizs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: filteredQuizs.length,
              itemBuilder: (ctx, index) => LeaderboardsItem(
                quiz: filteredQuizs[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
