import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Extension.dart';
import '../events/AnimatedBottomNavBar.dart';

class CircularScanLogoFAB extends StatelessWidget {
  final String logo;
  const CircularScanLogoFAB(this.logo, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavBarEvent(
      child: Container(
        width: 33.0.scalablePixel, // Adjust as needed
        height: 33.0.scalablePixel, // Adjust as needed
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              context.colorScheme.primary,
              context.colorScheme.primary
                  .withOpacity(0.8), // Adjust opacity as needed
            ],
          ),
          border: Border.all(
            color: context.colorScheme.onPrimary,
            width: 2.0, // Adjust border width as needed
          ),
        ),
        child: Center(
          child: SvgPicture.asset(
            logo,
            width: 25.0.scalablePixel, // Adjust as needed
            height: 25.0.scalablePixel, // Adjust as needed
            color: context.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
