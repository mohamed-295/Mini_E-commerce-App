class Cart {
  final List<CartItem> items;

  Cart({required this.items});

  factory Cart.fromJson(dynamic json) {
    if (json is List) {
      List<CartItem> items = json.map((item) => CartItem.fromJson(item)).toList();
      return Cart(items: items);
    }  else if (json is Map<String, dynamic>) {
      List<CartItem> items = json.values.map((item) => CartItem.fromJson(item)).toList();
      return Cart(items: items);
    } else {
      throw Exception('Invalid JSON format for Cart');
    }
  }
  double getTotal() {
    return items.fold(0, (total, item) => total + (item.price * item.quantity));
  }
}



class CartItem {
  final int id;
  final int productId;
  final String name;
  final String description;
  final String image;
  final double price;
  final int quantity;
  final double total;
  final bool isOrdered;
  final String createdAt;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
    required this.total,
    required this.isOrdered,
    required this.createdAt,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      productId: json['product_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: double.parse(json['price']),
      quantity: json['quantity'],
      total: json['total'].toDouble(),
      isOrdered: json['is_ordered'] == "1",
      createdAt: json['created_at'],
    );
  }
}