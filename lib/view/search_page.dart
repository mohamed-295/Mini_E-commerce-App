import 'dart:async';
import 'package:final_project/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../controller/product_controller.dart';
import '../model/product_model.dart';
import 'product_details_page.dart';
import 'widgets/image_loading.dart';
import 'widgets/shimmer_widget.dart';

class SearchPage extends StatefulWidget {
  final VoidCallback onSearchClosed;

  const SearchPage({Key? key, required this.onSearchClosed}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      Provider.of<ProductController>(context, listen: false).searchProducts(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.primaryColorDark),
          onPressed: () {
            widget.onSearchClosed();
            Navigator.pop(context);
          },
        ),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
          ),
          onChanged: _onSearchChanged,
          onSubmitted: (name) {
            Provider.of<ProductController>(context, listen: false).searchProducts(name);
          },
        ),
      ),
      body: Consumer<ProductController>(
        builder: (context, productController, child) {
          if (productController.isLoading) {
            return ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ShimmerWidget.rectangular(width: double.infinity, height: 80),
                ),
              ),
            );
          }
          if (productController.products.isEmpty) {
            return Center(child: Text('No products found.'));
          }
          return ListView.builder(
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              Product product = productController.products[index];
              return Card(
                margin: EdgeInsets.all(8),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12),
                  leading: SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: ImageLoading(
                        url: product.image,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  title: Text(product.name, style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.primaryColorDark)),
                  subtitle: Text('Price: \$${product.price}', style: TextStyle(color: AppColor.textSecondaryColor)),
                  trailing: Icon(Icons.arrow_forward_ios, color: AppColor.primaryColor),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          productId: product.id,
                          title: product.name,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}