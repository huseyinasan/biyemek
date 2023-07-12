class Product {
  final String name;
  final double price;
  final double discountedPrice;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.discountedPrice,
    required this.description,
  });

  // Convert the Product object to a map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'discountedPrice': discountedPrice,
      'description': description,
    };
  }
}
