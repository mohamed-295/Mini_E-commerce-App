import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/widgets/custom_app_bar.dart';
import 'package:final_project/view/widgets/item_card.dart';
import 'package:final_project/view/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/product_controller.dart';
import '../view/widgets/grid_view_builder.dart';
import 'product_details_page.dart';

class ProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryBackgroundColor,
      appBar:CustomAppBar(title: 'Products',leadingColor: AppColor.secondaryColorDark,),
      body: FutureBuilder(
        future: Provider.of<ProductController>(context, listen: false)
            .fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
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
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else {
            return Consumer<ProductController>(
              builder: (context, productController, child) {
                return GridViewBuilder(
                  items: productController.products,
                  itemBuilder: (context, product, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsPage(productId: product.id,title: product.name,),
                            ),
                          );
                        },
                        child: ItemCard(
                            cardWidth: 200,
                            fontSize: 16,
                            color1: AppColor.secondaryColor,
                            image: product.image,
                            name: product.name,
                            colorChange: 0,
                            imageWidth: 140,
                            imageHeight: 120));
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
