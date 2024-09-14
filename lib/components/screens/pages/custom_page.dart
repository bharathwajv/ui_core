import '../../Extension.dart';
import '../../buttons/back_button.dart';
import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {
  final Widget body;
  final String title;
  final IconData? backButtonIcon;
  final Widget? topRightComponent; // New optional parameter

  const PageTemplate({
    super.key,
    required this.body,
    required this.title,
    this.backButtonIcon,
    this.topRightComponent, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            // Background
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.onPrimary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            // Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(16.0.scalablePixel),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: context.textTheme.modifiedTextTheme(
                          context.textTheme.displayMedium,
                          context.colorScheme.onSecondaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
                // Body
                Expanded(
                  child: body,
                ),
              ],
            ),
            // Back button
            Positioned(
              top: 16.0.scalablePixel,
              left: 16.0.scalablePixel,
              child: BackButtonWidget(
                backButtonIcon ?? Icons.chevron_left,
              ),
            ),
            // Top right component (if provided)
            if (topRightComponent != null)
              Positioned(
                top: 16.0.scalablePixel,
                right: 16.0.scalablePixel,
                child: topRightComponent!,
              ),
          ],
        ),
      ),
    );
  }
}
