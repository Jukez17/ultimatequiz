import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/game_quizes.dart';

final quizProvider = Provider((ref) {
  return quizGames;
});