import 'BottomNavBarController.dart';
import 'package:flutter/material.dart';

class AnimatedMenuFABEvent extends StatelessWidget {
  final Widget child;

  const AnimatedMenuFABEvent({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: BottomNavBarController().isVisible,
      builder: (context, isVisible, _) {
        return AnimatedOpacity(
          opacity: !isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: child,
        );
      },
    );
  }
}
