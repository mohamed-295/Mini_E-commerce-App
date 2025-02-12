import 'package:final_project/model/product_model.dart';

class Category {
  final int id;
  final String name;
  final String description;
  final String image;
  final List<Product> products;

  Category({required this.id, required this.name, required this.description, required this.image, required this.products});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      products: json['products'] != null ? (json['products'] as List).map((productJson) => Product.fromJson(productJson)).toList() : [],
    );
  }
}