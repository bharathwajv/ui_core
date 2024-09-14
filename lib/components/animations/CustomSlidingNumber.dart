import 'sliding_number.dart';
import '../plugins/ElegantSpring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomSlidingNumber extends StatelessWidget {
  final num amount; // This allows for int, double, etc.
  final TextStyle style;
  final Duration duration;

  const CustomSlidingNumber(
      {super.key,
      required this.amount,
      required this.style,
      this.duration = const Duration(milliseconds: 500)});

  @override
  Widget build(BuildContext context) {
    final Curve curve = ElegantSpring(duration: 150.ms, bounce: 0.25);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '₹',
          style: style,
        ),
        RepaintBoundary(
          child: SlidingNumber(
            number: amount.toInt(),
            style: style,
            duration: duration,
            curve: curve,
          ),
        ),
      ],
    );
  }
}
