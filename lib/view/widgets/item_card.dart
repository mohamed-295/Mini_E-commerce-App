import 'package:final_project/view/widgets/image_loading.dart';
import 'package:flutter/material.dart';
import 'package:final_project/theme/app_color.dart';

class ItemCard extends StatelessWidget {
  final String image;
  final String name;
  final int colorChange;
  final Color color1;
  final Color? color2;
  final double imageWidth;
  final double imageHeight;
  final double? cardWidth;
  final double? cardHeight;
  final double? fontSize;

  const ItemCard({
    super.key,
    required this.image,
    required this.name,
    required this.colorChange,
    required this.imageWidth,
    required this.imageHeight,
    required this.color1,
    this.color2,
    this.cardWidth,
    this.cardHeight, this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorChange == 0 ? color1 : color2,
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: cardWidth??imageWidth,
        height: cardHeight??imageHeight,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: ImageLoading(url: image, width: imageWidth, height: imageHeight),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                name,
                style: TextStyle(
                  fontSize: fontSize??12,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textLightColor,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}