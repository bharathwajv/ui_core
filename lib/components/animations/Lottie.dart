import '../Extension.dart';
import 'Loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class CustomLottieAnimationBuilder extends StatefulWidget {
  final String fileName;

  const CustomLottieAnimationBuilder({super.key, required this.fileName});

  @override
  _CustomLottieAnimationBuilderState createState() =>
      _CustomLottieAnimationBuilderState();
}

class _CustomLottieAnimationBuilderState
    extends State<CustomLottieAnimationBuilder> {
  late final Future<LottieComposition> _composition;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LottieComposition>(
      future: _composition,
      builder: (context, snapshot) {
        var composition = snapshot.data;
        if (composition != null) {
          return Lottie(
              composition: composition,
              height: 80.0.scalablePixel,
              frameRate: FrameRate.max,
              reverse: true);
        } else {
          return const Center(child: AppLoadingIndicator());
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _composition = _loadComposition(widget.fileName);
  }

  Future<LottieComposition> _loadComposition(String fileName) async {
    var assetData = await rootBundle.load(fileName);
    return await LottieComposition.fromByteData(assetData);
  }
}
