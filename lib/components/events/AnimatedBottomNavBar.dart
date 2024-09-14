import '../Extension.dart';
import 'BottomNavBarController.dart';
import '../plugins/ElegantSpring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedBottomNavBarEvent extends StatelessWidget {
  final Widget child;
  final Duration animationDuration;

  const AnimatedBottomNavBarEvent({
    super.key,
    required this.child,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: BottomNavBarController().isVisible,
      builder: (context, isVisible, _) {
        return Animate(
          effects: [
            SlideEffect(
              begin: const Offset(0, 1),
              end: const Offset(0, 0),
              duration: animationDuration,
              curve: ElegantSpring(duration: 500.ms, bounce: 0.25),
            ),
            FadeEffect(
              begin: 0.0,
              end: 1.0,
              duration: animationDuration,
              curve: Curves.easeInCubic,
            ),
          ],
          target: isVisible ? 1 : 0,
          child: AnimatedContainer(
            duration: animationDuration,
            height:
                isVisible ? kBottomNavigationBarHeight + 20.scalablePixel : 0,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
