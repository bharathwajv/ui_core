import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ui_core/constant/core_colors.dart';

import '../../Extension.dart';
import '../../buttons/circle_buttons.dart';

Future<dynamic> customBottomSheet(
  BuildContext context,
  Widget content, {
  bool isDismissible = true,
  String? backgroundImage,
  bool isFloating = false,
}) {
  return showModalBottomSheet(
    enableDrag: isDismissible,
    isDismissible: isDismissible,
    useRootNavigator: true,
    isScrollControlled: true,
    context: context,
    backgroundColor: isFloating ? Colors.transparent : null,
    shape: isFloating
        ? null
        : const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
    builder: (BuildContext context) {
      Widget sheetContent = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: isFloating
                ? BorderRadius.circular(20.0)
                : const BorderRadius.vertical(top: Radius.circular(20.0)),
            color: context.colorScheme.surface,
            image: backgroundImage != null
                ? DecorationImage(
                    opacity: .2,
                    image: AssetImage(backgroundImage),
                    fit: BoxFit.cover,
                  )
                : null,
            boxShadow: isFloating
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ]
                : null,
          ),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Content
                  content,
                ],
              ),
              // Back button in top right corner
              Positioned(
                top: 16.0,
                right: 16.0,
                child: BackBtn(
                  icon: Icons.close,
                  isDismissible: isDismissible,
                ),
              ),
            ],
          ),
        ),
      );

      if (isFloating) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
          child: sheetContent,
        );
      } else {
        return sheetContent;
      }
    },
  );
}

Future<dynamic> ModalBottomSheet(BuildContext context, Widget content) {
  return showModalBottomSheet(
    useRootNavigator: true,
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
          color: context.colorScheme.secondaryContainer,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // The top notch-like divider
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: CoreColors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            content
          ],
        ),
      );
    },
  );
}

Future<dynamic> showAlert(
    BuildContext context, String header, String body, VoidCallback onClose) {
  return showModalBottomSheet(
    useRootNavigator: true,
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20.0)),
            color: context.colorScheme.surface,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // The top-notch-like divider
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  header,
                  style: context.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              // Body Content
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: Text(
                  body,
                  style: context.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              // Close Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onClose();
                  },
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
