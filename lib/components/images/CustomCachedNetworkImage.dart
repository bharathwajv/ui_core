import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final Alignment alignment;
  final double? width;
  final double? height;
  final Widget Function(
          BuildContext context, String url, DownloadProgress progress)?
      progressIndicatorBuilder;
  final Widget Function(BuildContext context, String url, dynamic error)?
      errorWidget;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.progressIndicatorBuilder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (isAssetUrl(imageUrl)) {
      return Image.asset(
        imageUrl,
        fit: fit,
        alignment: alignment,
        width: width,
        height: height,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        alignment: alignment,
        width: width,
        height: height,
        progressIndicatorBuilder: progressIndicatorBuilder != null
            ? (context, url, downloadProgress) =>
                progressIndicatorBuilder!(context, url, downloadProgress)
            : null,
        errorWidget: errorWidget != null
            ? (context, url, error) => errorWidget!(context, url, error)
            : null,
      );
    }
  }

  bool isAssetUrl(String url) {
    return url.startsWith('assets/') || url.startsWith('asset:');
  }
}
