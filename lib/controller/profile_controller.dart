import 'package:flutter/material.dart';
import 'package:final_project/service/api_service.dart';
import 'package:final_project/service/cashe_service.dart';
import 'package:final_project/model/user_model.dart';
import 'package:final_project/model/order_model.dart';

class ProfileController extends ChangeNotifier {
  final ApiService apiService;

  ProfileController(this.apiService);

  Future<UserModel?> getUserDetails() async {
    return await CasheService.getUser();
  }

  Future<List<Order>> getOrders() async {
    final user = await CasheService.getUser();
    if (user != null) {
      final data = await apiService.fetchData('orders', token: user.token);
      return (data['order'] as List).map((order) => Order.fromJson(order)).toList();
    }
    return [];
  }

  Future<int> getTotalOrders() async {
    final orders = await getOrders();
    return orders.length;
  }

  Future<double> getTotalAmountSpent() async {
    final orders = await getOrders();
    double totalAmount = 0;
    for (var order in orders) {
      totalAmount += order.total;
    }
    return totalAmount;
  }
}