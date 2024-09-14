import '../../Extension.dart';
import '../../buttons/custom_text_button.dart';
import 'package:flutter/material.dart';

Future<bool?> showCustomDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String noButtonText,
  required String yesButtonText,
  Function()? onYesPressed,
}) async {
  return showDialog<bool>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: context.colorScheme.onPrimary,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0.scalablePixel),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: context.textTheme.modifiedTextTheme(
                  context.textTheme.headlineMedium,
                  context.colorScheme.onSurface,
                ),
              ),
              // const BackButtonWidget(
              //   Icons.close,
              // ),
            ],
          ),
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.0.scalablePixel),
          child: Text(
            content,
            style: context.textTheme.modifiedTextTheme(
              context.textTheme.bodyLarge,
              context.colorScheme.onSurface,
            ),
          ),
        ),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTextButton(
                  isOutlined: true,
                  buttonText: Text(
                    noButtonText,
                    style: context.textTheme.justColor(
                      context.colorScheme.primary,
                    ),
                  ),
                  onClick: () async => Navigator.of(context).pop(false),
                  color: context.colorScheme.primary,
                  tintedBackground: true,
                  minWidth: 47.scalablePixel),
              SizedBox(width: 15.0.scalablePixel),
              CustomTextButton(
                  buttonText: Text(yesButtonText),
                  onClick: () async => Navigator.of(context).pop(true),
                  color: context.colorScheme.primary,
                  minWidth: 47.scalablePixel),
            ],
          )
        ],
      );
    },
  );
}

Future<String?> showInputDialog({
  required BuildContext context,
  required String title,
  required String hintText,
  bool isRequired = true,
}) async {
  String? inputText;
  return showDialog<String?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        surfaceTintColor: Colors.transparent,
        backgroundColor: context.colorScheme.onPrimary,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0.scalablePixel),
          child: Text(
            title,
            style: context.textTheme.modifiedTextTheme(
              context.textTheme.headlineMedium,
              context.colorScheme.onSurface,
            ),
          ),
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.0.scalablePixel),
          child: TextField(
            onChanged: (value) {
              inputText = value;
            },
            decoration: InputDecoration(
              hintText: hintText,
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextButton(
                  isOutlined: true,
                  buttonText: Text(
                    "Cancel",
                    style: context.textTheme.justColor(
                      context.colorScheme.primary,
                    ),
                  ),
                  onClick: () async => Navigator.of(context).pop(null),
                  color: context.colorScheme.primary,
                  tintedBackground: true,
                  minWidth: 47.scalablePixel),
              SizedBox(width: 15.0.scalablePixel),
              CustomTextButton(
                  buttonText: const Text('OK'),
                  onClick: () async {
                    if (isRequired &&
                        (inputText == null || inputText!.isEmpty)) {
                      // Show an error message or handle the required input case
                      return;
                    }
                    Navigator.of(context).pop(inputText);
                  },
                  color: context.colorScheme.primary,
                  minWidth: 47.scalablePixel),
            ],
          )
        ],
      );
    },
  );
}
