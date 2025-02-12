import 'package:final_project/controller/category_controller.dart';
import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/category_items_page.dart';
import 'package:final_project/view/category_page.dart';
import 'package:final_project/view/widgets/item_card.dart';
import 'package:final_project/view/widgets/list_view_builder.dart';
import 'package:final_project/view/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Categories',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryPage()),
                  );
                },
                child: Text('See More',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          ),
          FutureBuilder(
            future: Provider.of<CategoryController>(context, listen: false)
                .fetchCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListViewBuilder(
                  length: 5,
                  items: List.filled(5, null),
                  itemBuilder: (context, category, index) {
                    return ShimmerWidget.rectangular(
                      width: 80,
                      height: 40,
                      baseColor: AppColor.shimmerPrimaryBaseColor,
                      highlightColor: AppColor.shimmerPrimaryHighlightColor,
                    );
                  },
                  listHeight: 40,
                  listWidth: 80,
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Consumer<CategoryController>(
                  builder: (context, categoryController, child) {
                    return ListViewBuilder(
                      length: 8,
                      items: categoryController.categories,
                      itemBuilder: (context, category, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryItemsPage(categoryId: category.id, title: category.name),
                              ),
                            );
                          },
                          child: ItemCard(
                            fontSize: 10,
                            cardHeight: 60,
                            cardWidth: 80,
                            color1: AppColor.primaryColorDark,
                            image: category.image,
                            name: category.name,
                            colorChange: 0,
                            imageWidth: 80,
                            imageHeight: 40,
                          ),
                        );
                      },
                      listHeight: 50,
                      listWidth: 100,
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
