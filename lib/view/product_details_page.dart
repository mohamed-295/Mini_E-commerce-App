import 'package:final_project/controller/cart_controller.dart';
import 'package:final_project/model/user_model.dart';
import 'package:final_project/service/cashe_service.dart';
import 'package:final_project/view/cart_page.dart';
import 'package:final_project/view/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/product_controller.dart';
import '../model/product_model.dart';
import '../theme/app_color.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productId;
  final String title;
  final bool showCartIcon;

  ProductDetailsPage(
      {required this.productId, required this.title, this.showCartIcon = true});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;
  late UserModel _user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    UserModel? user = await CasheService.getUser();
    setState(() {
      _user = user!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondaryBackgroundColor,
        title: Text(widget.title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.secondaryColorDark)),
        actions: widget.showCartIcon
            ? [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartPage()));
                  },
                ),
              ]
            : null,
      ),
      body: FutureBuilder<Product?>(
        future: Provider.of<ProductController>(context, listen: false)
            .fetchProductById(widget.productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerLoading();
          } else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Product not found'));
          } else {
            Product product = snapshot.data!;
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: AppColor.secondaryColorDark, width: 4),
                              color: AppColor.secondaryBackgroundColor,
                            ),
                            child: Card(
                              borderOnForeground: true,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(product.image),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(product.name,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.secondaryColorDark)),
                          SizedBox(height: 8),
                          Text(product.description),
                          SizedBox(height: 8),
                          Text('Price: \$${product.price}'),
                          SizedBox(height: 8),
                          Text('Quantity: ${product.quantity}'),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (quantity > 1) quantity--;
                                  });
                                },
                              ),
                              Text(quantity.toString(),
                                  style: TextStyle(fontSize: 18)),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 16,
                  right: 16,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Provider.of<CartController>(context, listen: false)
                                .addToCart(product.id, quantity, _user.token);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      '$quantity x ${product.name} added to cart successfully'),
                                  backgroundColor: AppColor.successColor),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.secondaryColorDark,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
