import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/quiz.dart';

class FavoriteQuizNotifier extends StateNotifier<List<Quiz>> {
  FavoriteQuizNotifier() : super([]);

  bool toggleQuizFavoriteStatus(Quiz quiz) {
    final quizIsFavorite = state.contains(quiz);

    if (quizIsFavorite) {
      state = state.where((q) => q.id != quiz.id).toList();
      return false;
    } else {
      state = [...state, quiz];
      return true;
    }
  }
}

final favoriteQuizProvider =
    StateNotifierProvider<FavoriteQuizNotifier, List<Quiz>>((ref) {
  return FavoriteQuizNotifier();
});
