import 'package:final_project/controller/category_controller.dart';
import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/product_details_page.dart';
import 'package:final_project/view/widgets/custom_app_bar.dart';
import 'package:final_project/view/widgets/image_loading.dart';
import 'package:final_project/view/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryItemsPage extends StatelessWidget {
  final int categoryId;
  final String title;

  const CategoryItemsPage({super.key, required this.categoryId, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryBackgroundColor,
      appBar: CustomAppBar(title: title ),
      body: FutureBuilder(
        future: Provider.of<CategoryController>(context, listen: false).fetchCategoryProducts(categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerLoading();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Consumer<CategoryController>(
              builder: (context, categoryController, child) {
                if (categoryController.categoryProducts.isEmpty) {
                  return Center(child: Text('No products found.',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: AppColor.secondaryColorDark),));
                }
                return ListView.builder(
                  itemCount: categoryController.categoryProducts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: AppColor.secondaryBackgroundColor,
                        border: Border.all(color: AppColor.primaryColorLight, width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(title: categoryController.categoryProducts[index].name,productId: categoryController.categoryProducts[index].id),
                            ),
                          );
                        },
                        child: Container(
                          height: 120, 
                          child: Row(
                            children: [
                                ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ImageLoading(
                                  url: categoryController.categoryProducts[index].image,
                                  width: 100,
                                  height: 80,
                                ),
                                ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(categoryController.categoryProducts[index].name, style: Theme.of(context).textTheme.titleMedium),
                                    SizedBox(height: 4),
                                    Text(categoryController.categoryProducts[index].description, style: Theme.of(context).textTheme.labelMedium),
                                    SizedBox(height: 4),
                                    Text('Price: \$${categoryController.categoryProducts[index].price}', style: Theme.of(context).textTheme.labelMedium),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}