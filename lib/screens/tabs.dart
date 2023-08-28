import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/favorites_provider.dart';
import '../providers/filters_provider.dart';
import '../screens/quiz_categories.dart';
import '../screens/filters.dart';
import '../screens/quizzes.dart';
import '../screens/profile.dart';
import '../screens/leaderboards.dart';
import '../widgets/drawer/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableQuiz = ref.watch(filteredQuizProvider);

    Widget activePage = CategoriesScreen(
      availableQuiz: availableQuiz,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = LeaderboardsScreen(filteredQuizs: availableQuiz);
      activePageTitle = 'Leaderboards';
    } else if (_selectedPageIndex == 2) {
      final favoriteQuiz = ref.watch(favoriteQuizProvider);
      activePage = QuizsScreen(
        quizs: favoriteQuiz,
      );
      activePageTitle = 'Your Favorites';
    } else if (_selectedPageIndex == 3) {
      activePage = ProfileScreen();
      activePageTitle = 'Profile';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Colors.white, // Color of the selected icon and label
        unselectedItemColor:
            Colors.grey, // Color of the unselected icon and label
        backgroundColor: Colors.blue, // Background color of the navigation bar
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_rounded),
            label: 'Leaderboards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
