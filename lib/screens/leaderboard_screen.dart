import 'package:flutter/material.dart';

import '../widgets/leaderboard/game_leaderboard.dart';

class LeaderboardScreen extends StatelessWidget {
  final String gameTitle;

  const LeaderboardScreen({
    super.key,
    required this.gameTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$gameTitle Leaderboard'),
      ),
      body: Center(
        child: GameLeaderboard(gameTitle: gameTitle),
      ),
    );
  }
}
