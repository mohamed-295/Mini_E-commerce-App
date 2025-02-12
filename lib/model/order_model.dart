class Order {
  final int productId;
  final String name;
  final String description;
  final String image;
  final double price;
  final int quantity;
  final double total;
  final DateTime createdAt;

  Order({
    required this.productId,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
    required this.total,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      productId: json['product_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: double.parse(json['price']),
      quantity: json['quantity'],
      total: double.parse(json['total']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}