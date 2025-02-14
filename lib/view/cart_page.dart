import 'package:final_project/model/user_model.dart';
import 'package:final_project/service/cashe_service.dart';
import 'package:final_project/theme/app_color.dart';
import 'package:final_project/view/widgets/custom_app_bar.dart';
import 'package:final_project/view/widgets/image_loading.dart';
import 'package:final_project/view/widgets/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:final_project/controller/cart_controller.dart';
import 'package:final_project/service/api_service.dart';
import 'package:final_project/model/cart_model.dart';
import 'package:final_project/view/product_details_page.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartController _controller;
  Future<Cart>? _cart;
  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _controller = CartController(ApiService());
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    UserModel? user = await CasheService.getUser();
    setState(() {
      _user = user;
      if (_user != null) {
        _cart = _controller.fetchCartItems(_user!.token);
      }
    });
  }

  Future<void> _refreshCart() async {
    if (_user != null) {
      setState(() {
        _cart = _controller.fetchCartItems(_user!.token);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryBackgroundColor,
      appBar: CustomAppBar(
        title: 'Cart',
        isLeading: false,
      ),
      body: RefreshIndicator(
        color: AppColor.primaryColor,
        onRefresh: _refreshCart,
        child: FutureBuilder<Cart>(
          future: _cart,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerLoading();
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Add items to your cart 🛒',
                      style: Theme.of(context).textTheme.titleMedium));
            } else if (snapshot.hasData && snapshot.data!.items.isNotEmpty) {
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: snapshot.data!.items.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data!.items[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: AppColor.secondaryBackgroundColor,
                          border: Border.all(
                              color: AppColor.primaryColorLight, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                  title: item.name,
                                  productId: item.productId,
                                  showCartIcon: false,
                                ),
                              ),
                            ).then((_) {
                              _refreshCart();
                            });
                          },
                          child: Container(
                            height: 120,
                            child: Row(
                              children: [
                                ImageLoading(
                                  url: item.image,
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(item.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                      SizedBox(height: 4),
                                      Text('\$${item.price} x ${item.quantity}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                      SizedBox(height: 4),
                                      Text('Price: \$${item.price}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.delete,
                                        color: AppColor.errorColor),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: AppColor
                                                .secondaryBackgroundColor,
                                            title: Text(
                                              'Remove item from cart?',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  try {
                                                    await _controller
                                                        .removeFromCart(item.id,
                                                            _user!.token);
                                                    await _refreshCart();
                                                    Navigator.pop(context);
                                                  } catch (error) {}
                                                },
                                                child: Text('Remove',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 20,
                    left: 16,
                    right: 16,
                    child: Column(
                      children: [
                        Text(
                            'Total: \$${snapshot.data!.getTotal().toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleMedium),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  final productIds = snapshot.data!.items
                                      .map((item) => item.id)
                                      .toList();
                                  try {
                                    await Provider.of<CartController>(context,
                                            listen: false)
                                        .checkout(productIds, _user!.token);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Order placed!'),
                                          duration: Duration(seconds: 2),
                                          backgroundColor:
                                              AppColor.successColor),
                                    );
                                    await _refreshCart();
                                  } catch (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Error placing order: $error')),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.errorColor,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                child: Text(
                                  'Checkout',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                  child: Text('Your cart is empty',
                      style: Theme.of(context).textTheme.titleMedium));
            }
          },
        ),
      ),
    );
  }
}
