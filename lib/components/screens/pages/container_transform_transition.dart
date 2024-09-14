import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ui_core/constant/core_colors.dart';

class ContainerTransformTransition extends StatelessWidget {
  final Widget closedBuilder;
  final Widget openBuilder;
  final ContainerTransitionType transitionType;
  final Duration transitionDuration;

  const ContainerTransformTransition({
    super.key,
    required this.closedBuilder,
    required this.openBuilder,
    this.transitionType = ContainerTransitionType.fade,
    this.transitionDuration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      tappable: false,
      openElevation: 0,
      closedElevation: 0,
      closedColor: CoreColors.transparent,
      openColor: CoreColors.transparent,
      useRootNavigator: true, // to show full page
      transitionType: transitionType,
      transitionDuration: transitionDuration,
      closedBuilder: (context, VoidCallback openContainer) {
        return GestureDetector(
          onTap: openContainer,
          child: closedBuilder,
        );
      },
      openBuilder: (context, _) => openBuilder,
    );
  }
}
