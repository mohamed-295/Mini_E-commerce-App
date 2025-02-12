import 'package:final_project/controller/product_controller.dart';
import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/product_details_page.dart';
import 'package:final_project/view/product_list_page.dart';
import 'package:final_project/view/widgets/item_card.dart';
import 'package:final_project/view/widgets/list_view_builder.dart';
import 'package:final_project/view/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({
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
                padding: const EdgeInsets.all(8),
                child: Text('Products',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondaryColorDark,
                    ))
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductListPage()),
                  );
                },
                child: Text('See More',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          ),
          FutureBuilder(
            future: Provider.of<ProductController>(context, listen: false)
                .fetchProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListViewBuilder(
                  length: 8,
                  items: List.filled(8, null),
                  itemBuilder: (context, product, index) {
                    return ShimmerWidget.rectangular(
                      width: 120,
                      height: 80,
                      baseColor: AppColor.shimmerSecondaryBaseColor,
                      highlightColor: AppColor.shimmerSecondaryHighlightColor,
                    );
                  },
                  listHeight: 100,
                  listWidth: 100,
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Consumer<ProductController>(
                  builder: (context, productController, child) {
                    return ListViewBuilder(
                      length: 8,
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
                            color1: AppColor.secondaryColor,
                            image: product.image,
                            name: product.name,
                            colorChange: 0,
                            imageWidth: 120,
                            imageHeight: 80,
                          ),
                        );
                      },
                      listHeight: 100,
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