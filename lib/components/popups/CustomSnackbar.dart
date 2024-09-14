import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    String actionLabel = 'OK',
    VoidCallback? onPressed,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
  }) {
    // toastification.show(
    //     pauseOnHover: false,
    //     context: context,
    //     type: ToastificationType.info,
    //     style: ToastificationStyle.minimal,
    //     description: Text(message),
    //     alignment: Alignment.bottomCenter,
    //     autoCloseDuration: duration,
    //     primaryColor: context.colorScheme.primary,
    //     borderRadius: BorderRadius.circular(12.0),
    //     boxShadow: lowModeShadow,
    //     showProgressBar: false);
    // // Remove existing Snackbars
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    // Show the new Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        action: onPressed != null
            ? SnackBarAction(
                label: actionLabel,
                onPressed: onPressed,
              )
            : null,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
