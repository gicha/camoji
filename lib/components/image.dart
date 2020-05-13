import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camoji/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

/// Image widget with placeholder.
/// Wrap around CachedNetworkImage with Shimmer placeholder.
/// Display image from given [url]. Example: [PLImage('https://your_image.png')]
/// You can manually configure heigth of Image([heigth]), width od Image([width]) and circular border radius([borderRadius])
/// {@category Widgets}
class PLImage extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final String url;
  final BoxFit fit;
  final Color color;
  const PLImage(
    this.url, {
    Key key,
    this.height,
    this.width,
    this.borderRadius = 0,
    this.fit = BoxFit.cover,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: fit,
        height: height,
        width: width,
        color: color,
        errorWidget: (context, str, obj) => Container(
          height: height,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 4),
          alignment: Alignment.center,
          color: ITColors.general,
          child: Text(
            "Не удалось загрузить изображение",
            style: ITStyle.create(fontSize: 12, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        placeholder: (context, url) => Container(
          height: height,
          width: width,
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadius)),
          child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.grey[100],
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
