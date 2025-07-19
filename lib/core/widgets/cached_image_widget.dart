import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImage extends CachedNetworkImage {
  CachedImage({
    required String? imageUrl,
    required double width,
    required double height,
    double? borderRadius,
    super.fit,
    super.key,
  }) : super(
         imageUrl: imageUrl ?? "",
         imageBuilder: (context, imageProvider) => Container(
           width: width,
           height: height,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(borderRadius ?? 0),
             image: DecorationImage(image: imageProvider, fit: fit),
           ),
         ),
         errorWidget: (context, url, error) => CircleAvatar(
           radius: width / 2,
           backgroundColor: Colors.blueGrey,
           child: Icon(Icons.error_outline, color: Colors.white, size: width * 2),
         ),
         placeholder: (context, url) => ClipRRect(
           borderRadius: BorderRadius.circular(borderRadius ?? 0),
           child: Shimmer.fromColors(
             baseColor: Colors.grey[300]!,
             highlightColor: Colors.grey[100]!,
             period: const Duration(milliseconds: 800),
             child: Container(width: width, height: height, color: Colors.white),
           ),
         ),
       );
}
