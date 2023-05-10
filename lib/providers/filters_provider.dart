import 'package:flutter_riverpod/flutter_riverpod.dart';

import './quiz_provider.dart';

enum Filter {
  easy,
  medium,
  hard,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.easy: false,
          Filter.medium: false,
          Filter.hard: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; // not allowed! => mutating state
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredQuizProvider = Provider((ref) {
  final quizs = ref.watch(quizProvider);
  final activeFilters = ref.watch(filtersProvider);

  return quizs.where((quiz) {
    if (activeFilters[Filter.easy]! && !quiz.isEasy) {
      return false;
    }
    if (activeFilters[Filter.medium]! && !quiz.isMedium) {
      return false;
    }
    if (activeFilters[Filter.hard]! && !quiz.isHard) {
      return false;
    }
    return true;
  }).toList();
});
