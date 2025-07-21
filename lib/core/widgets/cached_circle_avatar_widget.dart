import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedCircleAvatar extends CachedNetworkImage {
  CachedCircleAvatar({
    required String? imageUrl,
    required double radius,
    super.key,
  }) : super(
         fit: BoxFit.cover,
         imageUrl: imageUrl ?? '',
         imageBuilder: (_, imageProvider) => SizedBox(
           width: radius * 2,
           height: radius * 2,
           child: CircleAvatar(radius: radius, backgroundImage: imageProvider),
         ),
         errorWidget: (context, url, error) => CircleAvatar(
           radius: radius,
           //  backgroundColor: Colors.blueGrey,
           child: Icon(Icons.account_circle, size: radius * 2),
         ),
         placeholder: (context, url) => ClipOval(
           child: Shimmer.fromColors(
             baseColor: Colors.grey[400]!,
             highlightColor: Colors.grey[100]!,
             period: const Duration(milliseconds: 800),
             child: Container(width: radius * 2, height: radius * 2, color: Colors.white),
           ),
         ),
       );
}
