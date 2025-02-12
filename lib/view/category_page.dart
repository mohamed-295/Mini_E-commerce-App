import 'package:final_project/controller/category_controller.dart';
import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/category_items_page.dart';
import 'package:final_project/view/widgets/custom_app_bar.dart';
import 'package:final_project/view/widgets/item_card.dart';
import 'package:final_project/view/widgets/grid_view_builder.dart';
import 'package:final_project/view/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  final bool? isLeading;
  const CategoryPage({super.key,  this.isLeading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryBackgroundColor,
      appBar: CustomAppBar(title: 'Categories', isLeading: isLeading ?? true),
      body: Consumer<CategoryController>(
        builder: (context, categoryController, child) {
          if (categoryController.categories.isEmpty) {
            return  Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: 8,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return ShimmerWidget.rectangular(
                    width: double.infinity,
                    height: 200,
                  );
                },
              ),
            );
          }
          return Container(
            padding: const EdgeInsets.all(12.0),
            child: GridViewBuilder(
              items: categoryController.categories,
              itemBuilder: (context, category, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryItemsPage(categoryId: category.id, title: category.name),
                      ),
                    );
                  },
                  child: ItemCard(
                    fontSize: 16,
                    color1: AppColor.primaryColorDark,
                    image: category.image,
                    name: category.name,
                    colorChange: 0,
                    imageWidth: 160, 
                    imageHeight: 120, 
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}