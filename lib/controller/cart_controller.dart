import 'package:flutter/material.dart';
import 'package:final_project/model/cart_model.dart';
import 'package:final_project/service/api_service.dart';

class CartController extends ChangeNotifier {
  final ApiService apiService;

  CartController(this.apiService);

  Future<Cart> fetchCartItems(String token) async {
    final response = await apiService.fetchData('cart', token: token);
    return Cart.fromJson(response);
  }

  Future<void> addToCart(int productId, int quantity, String token) async {
    await apiService.postData('carts/add', {'product_id': productId, 'quantity': quantity}, token: token);
    notifyListeners();
  }

  Future<void> removeFromCart(int cartItemId, String token) async {
    await apiService.fetchData('carts/$cartItemId/remove', token: token, id: cartItemId);
    notifyListeners();
  }

  Future<void> checkout(List<int> productIds, String token) async {
    await apiService.postData('carts/checkout', {'product_ids': productIds, 'token': token});
    notifyListeners();
  }
}