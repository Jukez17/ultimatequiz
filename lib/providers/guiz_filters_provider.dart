import 'package:flutter_riverpod/flutter_riverpod.dart';

import './quiz_provider.dart';

enum Filter {
  mobileGame,
  history,
  sports,
  realTimeStrategy,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.mobileGame: false,
          Filter.history: false,
          Filter.sports: false,
          Filter.realTimeStrategy: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider = StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
  (ref) => FiltersNotifier(),
);

final filteredQuizProvider = Provider((ref) {
  final gameQuizs = ref.watch(quizProvider);
  final activeFilters = ref.watch(filtersProvider);

  return gameQuizs.where((gamequiz) {
    if (activeFilters[Filter.mobileGame]! && !gamequiz.mobileGame) {
      return false;
    }
    if (activeFilters[Filter.history]! && !gamequiz.history) {
      return false;
    }
    if (activeFilters[Filter.sports]! && !gamequiz.sports) {
      return false;
    }
    if (activeFilters[Filter.realTimeStrategy]! &&
        !gamequiz.realTimeStrategy) {
      return false;
    }
    return true;
  }).toList();
});