import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// move all .animate to this class

class CustomAnimations extends StatefulWidget {
  final List<Widget> children;

  const CustomAnimations({super.key, required this.children});

  @override
  _CustomAnimationsState createState() => _CustomAnimationsState();
}

class _CustomAnimationsState extends State<CustomAnimations> {
  final Duration delay = const Duration(milliseconds: 50);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.children.length, (index) {
        final delayDuration = Duration(
            milliseconds: ((index * 30) + delay.inMilliseconds).round());
        return widget.children[index].animateWithBounceEffect(delayDuration);
      }),
    );
  }
}

extension AnimateChildrenWithSubtleEffect on List<Widget> {
  List<Widget> animateChildrenWithSubtleEffect(Duration baseDuration) {
    return List.generate(length, (index) {
      final delayDuration = Duration(milliseconds: index * 50);
      final totalDuration = baseDuration + delayDuration;
      return this[index]
          .animate()
          .fadeIn(
            duration: totalDuration,
            curve: Curves.easeOut,
          )
          .slide(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
            duration: totalDuration,
            curve: Curves.easeOut,
          );
    });
  }
}

extension AnimateWithBounceEffect on Widget {
  Widget animateWithBounceEffect(Duration duration) {
    return animate().fadeIn(duration: duration).slide(
          begin: const Offset(0.3, 0.3),
          delay: duration,
          end: Offset.zero,
          curve: Curves.ease,
        );
  }
}
