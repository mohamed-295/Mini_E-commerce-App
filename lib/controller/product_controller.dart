import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../model/product_model.dart';
import '../service/api_service.dart';

class ProductController with ChangeNotifier {
  final ApiService apiService;
  List<Product> _products = [];
  List<Product> _newArrivalProducts = [];
  bool _isLoading = false;

  ProductController(this.apiService);

  List<Product> get products => _products;
  List<Product> get newArrivalProducts => _newArrivalProducts;
  bool get isLoading => _isLoading;

 Future<void> fetchProducts({int retries = 3, int delayInSeconds = 2}) async {
  _setLoading(true);
  int attempt = 0;
  while (attempt < retries) {
    try {
      var data = await apiService.fetchData('products');
      _products = (data as List).map((json) => Product.fromJson(json)).toList();
      break; 
    } catch (e) {
      if (e.toString().contains("Too Many Attempts")) {
        attempt++;
        if (attempt < retries) {
          await Future.delayed(Duration(seconds: delayInSeconds));
        } else {
          print("Error fetching products: Too Many Attempts. Max retries reached.");
        }
      } else {
        print("Error fetching products: $e");
        break; 
      }
    }
  }
  _setLoading(false);
}

  Future<void> fetchNewArrivalProducts() async {
    _setLoading(true);
    try {
      var data = await apiService.fetchData('new_arrival_products');
      _newArrivalProducts = (data as List).map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      print("Error fetching new arrival products: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<Product?> fetchProductById(int productId) async {
  _setLoading(true);
  try {
    var data = await apiService.fetchData('products/$productId/show');
    return Product.fromJson(data);
  } catch (e) {
    print("Error fetching product by ID: $e");
    return null;
  } finally {
    _setLoading(false);
  }
}

  Future<void> searchProducts(String name) async {
    _setLoading(true);
    try {
      var data = await apiService.fetchData('search', name: name);
      _products = (data as List).map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      print("Error searching products: $e");
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