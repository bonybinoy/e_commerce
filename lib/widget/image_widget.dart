import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ImageWidget extends StatelessWidget {
  final String? imgUrl;
  final double? height;
  final BoxFit? fit;

  const ImageWidget({super.key, required this.imgUrl, this.height, this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl ?? '',
      placeholder: (context, url) => const SpinKitCircle(
        color: Colors.grey,
        size: 25,
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }
}
