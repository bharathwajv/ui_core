import 'dart:math' as math;

import 'package:flutter/material.dart';

class TextShimmer extends StatefulWidget {
  final AnimationController animationController;
  final int length;
  final String char;
  final int index;

  const TextShimmer({
    super.key,
    required this.animationController,
    required this.length,
    required this.char,
    required this.index,
  });

  @override
  State<TextShimmer> createState() => _TextShimmerState();
}

class TextShimmerAnimation extends StatefulWidget {
  final String text;

  const TextShimmerAnimation({super.key, required this.text});

  @override
  _TextShimmerAnimationState createState() => _TextShimmerAnimationState();
}

class _TextShimmerAnimationState extends State<TextShimmerAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            widget.text.length,
            (index) => TextShimmer(
              key: ValueKey('$index'),
              animationController: _animationController,
              length: widget.text.length,
              char: widget.text[index],
              index: index + 1,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animationController
      ..forward()
      ..repeat();
  }
}

class _TextShimmerState extends State<TextShimmer> {
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Text(
        widget.char,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: _colorAnimation.value!,
            ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    double startValue = (widget.index / widget.length) * 0.5;
    double endValue = math.min(startValue + 0.2, 1.0);
    _scaleAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.25)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.25, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50.0,
      ),
    ]).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(startValue, endValue),
      ),
    );

    _colorAnimation = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(
          begin: const Color(0xFF56CED0),
          end: const Color(0xFFbcfbff),
        ),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween: ColorTween(
          begin: const Color(0xFFbcfbff),
          end: const Color(0xFF3A777B),
        ),
        weight: 50.0,
      ),
    ]).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(startValue, endValue),
      ),
    );
  }
}
