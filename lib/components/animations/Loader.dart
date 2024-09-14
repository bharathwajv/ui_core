import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ui_core/constant/core_colors.dart';

import '../Extension.dart';

class AppLoadingIndicator extends StatelessWidget {
  final Color? color;
  final double? value;
  final double? width;
  final double? height;
  final double? strokeWidth;
  const AppLoadingIndicator(
      {super.key,
      this.value,
      this.color,
      this.width,
      this.height,
      this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    final progress = (value == null || value! < .05) ? null : value;

    return Center(
      child: SizedBox(
        width: width ?? 25.scalablePixel,
        height: height ?? 25.scalablePixel,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              color ?? context.colorScheme.primary),
          value: progress,
          strokeWidth: strokeWidth ?? 2.0,
        ),
      ),
    );
  }
}

class Loader extends StatelessWidget {
  final BuildContext context;

  final Widget child;
  const Loader({
    super.key,
    required this.context,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
        overlayColor: CoreColors.spinnerOverlay,
        useDefaultLoading: false,
        overlayWidgetBuilder: (progress) {
          //return Center(child: Lottie.asset(Constants.Asset_ChaiAnimation2));
          return const AppLoadingIndicator();
        },
        child: child);
  }

  static Future<void> runTimeConsumingMethord(
      BuildContext context, Future<void> Function() completionAction) async {
    showDialog(
      context: context,
      barrierColor: CoreColors.spinnerOverlay,
      barrierDismissible: false,
      builder: (BuildContext context) => const Center(
        child: AppLoadingIndicator(),
      ),
    );

    try {
      await completionAction();
    } finally {
      Navigator.pop(context);
    }
  }

  static startLoading(BuildContext context) async {
    context.loaderOverlay.show();
    await Future.delayed(const Duration(milliseconds: 500), () {
      context.loaderOverlay.hide();
    });
  }

  static stopLoading(BuildContext context) {
    context.loaderOverlay.hide();
  }
}
