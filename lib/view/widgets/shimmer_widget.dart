import 'package:final_project/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerWidget.rectangular({
    super.key,
    required this.width,
    required this.height, this.baseColor, this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor?? Colors.grey[300]!,
      highlightColor:highlightColor?? Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.secondaryBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        width: width,
        height: height,
      ),
    );
  }
}