import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_core/constant/core_constants.dart';

import '../Extension.dart';
import '../buttons/custom_text_button.dart';
import '../images/CustomCachedNetworkImage.dart';

class CustomErrorPage extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  final String image;
  const CustomErrorPage(
      {super.key, required this.errorDetails, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCachedNetworkImage(imageUrl: image),
            Text(
              kDebugMode
                  ? errorDetails.summary.toString()
                  : 'Oups! Something went wrong!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: kDebugMode ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            ),
            const SizedBox(height: 12),
            const Text(
              kDebugMode
                  ? 'https://docs.flutter.dev/testing/errors'
                  : "We encountered an error and we've notified our engineering team about it. Sorry for the inconvenience caused.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(height: 20),
            CustomTextButton(
              buttonText: const Text("Home"),
              onClick: () async => {context.goNamed(CoreConstants.route_home)},
              color: context.colorScheme.primary,
            )
          ],
        ),
      ),
    );
  }
}
