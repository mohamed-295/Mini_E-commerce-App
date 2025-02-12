import 'package:final_project/view/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';

class ShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ShimmerWidget.rectangular(
              width: double.infinity, height: 200),
          SizedBox(height: 16),
          ShimmerWidget.rectangular(
              width: double.infinity, height: 24),
          SizedBox(height: 8),
          ShimmerWidget.rectangular(
              width: double.infinity, height: 16),
          SizedBox(height: 8),
          ShimmerWidget.rectangular(
              width: double.infinity, height: 16),
          SizedBox(height: 8),
          ShimmerWidget.rectangular(
              width: double.infinity, height: 16),
        ],
      ),
    );
  }
}