import 'package:final_project/model/category_model.dart';
import 'package:final_project/model/product_model.dart';
import 'package:final_project/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CategoryController extends ChangeNotifier {
  List<Category> categories = [];
  List<Product> categoryProducts = [];
  Category? categoryDetails;
  bool _isLoading = false;
  final ApiService apiService;

  CategoryController(this.apiService);

  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    _setLoading(true);
    try {
      var data = await apiService.fetchData('categories');
      if (data != null && data is List) {
        categories = data.map((json) => Category.fromJson(json)).toList();
      } else {
        categories = [];
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchCategoryProducts(int categoryId) async {
    _setLoading(true);
    try {
      var data = await apiService.fetchData('categories/$categoryId/products');
      if (data != null && data is List) {
        categoryProducts = data.map((json) => Product.fromJson(json)).toList();
      } else {
        categoryProducts = [];
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchCategoryDetails(int categoryId) async {
    _setLoading(true);
    try {
      var data = await apiService.fetchData('categories/$categoryId/show');
      if (data != null && data is Map<String, dynamic>) {
        categoryDetails = Category.fromJson(data);
      } else {
        categoryDetails = null;
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}