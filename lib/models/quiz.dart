import 'package:flutter/material.dart';
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
    required this.title,
    required this.imageUrl,
    required this.duration,
    //required this.date,
    required this.complexity,
    required this.isEasy,
    required this.isMedium,
    required this.isHard,
  });

  final String id;
  final List<String> categories;
  final String title;
  final String imageUrl;
  final int duration;
  //final DateTime date;
  final Complexity complexity;
  final bool isEasy;
  final bool isMedium;
  final bool isHard;

  // String get formattedDate {
  //   return formatter.format(date);
  // }
}