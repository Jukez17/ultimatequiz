//import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Complexity {
  easy,
  medium,
  hard,
}

class Quiz {
  const Quiz({
    required this.id,
    required this.categories,
    required this.gameCategories,
    required this.title,
    required this.imageUrl,
    required this.duration,
    //required this.date,
    required this.complexity,
    required this.isEasy,
    required this.isMedium,
    required this.isHard,
    required this.mobileGame,
    required this.history,
    required this.sports,
    required this.realTimeStrategy,
  });

  final String id;
  final List<String> categories;
  final List<String> gameCategories;
  final String title;
  final String imageUrl;
  final int duration;
  //final DateTime date;
  final Complexity complexity;
  final bool isEasy;
  final bool isMedium;
  final bool isHard;
  final bool mobileGame;
  final bool history;
  final bool sports;
  final bool realTimeStrategy;

  // String get formattedDate {
  //   return formatter.format(date);
  // }
}