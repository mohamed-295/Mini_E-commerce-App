import 'package:final_project/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:final_project/view/search_page.dart';
import 'package:provider/provider.dart';
import 'package:final_project/controller/product_controller.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchPage(
                onSearchClosed: () {
                  Provider.of<ProductController>(context, listen: false).fetchProducts();
                },
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColor.textSecondaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.search),
              SizedBox(width: 8),
              Text('Search products...'),
            ],
          ),
        ),
      ),
    );
  }
}