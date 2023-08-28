import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class QuizTimer extends StatefulWidget {
  const QuizTimer({
    super.key,
    required this.duration,
    //required this.onTimerFinished,
    required this.animationController,
  });

  final Duration duration;
  //final VoidCallback onTimerFinished;
  //final VoidCallback resetTimer;
  final AnimationController animationController;

  @override
  QuizTimerState createState() => QuizTimerState();
}

class QuizTimerState extends State<QuizTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = widget.animationController;

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Handle timer finished event if needed
      }
    });

    resetTimer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void resetTimer() {
    _animationController.reset();
    _animationController.reverse(from: 10);
  }

  String get timerText {
    int remainingSeconds =
        (_animationController.value * widget.duration.inSeconds).ceil();
    int seconds = remainingSeconds % 60;
    var timeLeft = seconds.toString().padLeft(2, '0');
    return timeLeft;
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final timerRadius = isLandscape ? MediaQuery.of(context).size.width * 0.08 : MediaQuery.of(context).size.width * 0.14;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        int remainingSeconds =
            (_animationController.value * widget.duration.inSeconds).ceil();
        Color progressColor = Colors.transparent;
        if (remainingSeconds <= 6 && remainingSeconds > 4) {
          progressColor = Colors.yellow;
        } else if (remainingSeconds <= 4 && remainingSeconds > 0) {
          progressColor = Colors.red;
        } else {
          progressColor = Theme.of(context).colorScheme.primary;
        }

        return CircularPercentIndicator(
          radius: timerRadius,
          lineWidth: 10.0,
          percent: _animationController.value,
          center: Text(
            timerText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          arcType: ArcType.FULL_REVERSED,
          arcBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
          progressColor: progressColor,
        );
      },
    );
  }
}
