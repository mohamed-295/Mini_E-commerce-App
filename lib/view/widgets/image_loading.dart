import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';

class ImageLoading extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  const ImageLoading({super.key, required this.url, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: width ?? 120, 
        height: height ?? 80, 
        child: Image.network(
          url,
          fit: BoxFit.scaleDown,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: ShimmerWidget.rectangular(width: width ?? 120, height: height ?? 80),
              );
            }
          },
          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
            return Container(
              color: AppColor.secondaryBackgroundColor,
              child: Icon(Icons.error, size: 100, color: AppColor.errorColorDark),
            );
          },
        ),
      ),
    );
  }
}