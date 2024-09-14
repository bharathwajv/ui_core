import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum Response { success, failure }

class CustomOverlayDialog extends StatelessWidget {
  final String animationPath;
  final String text;
  final String confirmButtonText;
  final Completer<Response> completion = Completer();

  CustomOverlayDialog({
    super.key,
    required this.animationPath,
    required this.text,
    required this.confirmButtonText,
  });

  Future<Response?> show(BuildContext context) async {
    return showDialog<Response>(
      context: context,
      barrierDismissible: false,
      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Stack(
        children: [
          // Lottie Animation
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Lottie.asset(
              animationPath,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          // Text
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Confirm Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                completion.complete(Response.success);
              },
              child: Text(confirmButtonText),
            ),
          ),
        ],
      ),
    );
  }
}

// Example usage:
// Response? result = await CustomOverlayDialog(
//   animationPath: 'assets/animations/success.json',
//   text: 'Operation Successful!',
//   confirmButtonText: 'OK',
// ).show(context);

// if (result == Response.success) {
//   // Handle success
// } else {
//   // Handle failure
// }
