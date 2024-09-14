import 'package:flutter/material.dart';

import '../../Extension.dart';
import '../../buttons/custom_text_button.dart';
import '../../images/CustomCachedNetworkImage.dart';

class RouterOfflineScreen extends StatelessWidget {
  final String image;
  const RouterOfflineScreen(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomCachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.15,
              left: MediaQuery.of(context).size.width * 0.3,
              right: MediaQuery.of(context).size.width * 0.3,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 13),
                      blurRadius: 25,
                      color: Colors.black.withOpacity(0.17),
                    ),
                  ],
                ),
                child: CustomTextButton(
                    buttonText: const Text('Retry'),
                    onClick: () async => {},
                    color: context.colorScheme.primary),
              ))
        ],
      ),
    );
  }
}
