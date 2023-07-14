class Product {
  final String businessUid;
  final String id;
  final String businessName;
  final String imageUrl;
  final String name;
  final String type;
  final double amount;
  final String unit;
  final String lastDate;
  final String description;
  final double normalPrice;
  final double discountPrice;

  Product({
    required this.businessUid,
    required this.id,
    required this.businessName,
    required this.imageUrl,
    required this.name,
    required this.type,
    required this.amount,
    required this.unit,
    required this.lastDate,
    required this.description,
    required this.normalPrice,
    required this.discountPrice,
  });

  // Convert the Product object to a map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'businessUid': businessUid,
      'id': id,
      'businessName': businessName,
      'imageUrl': imageUrl,
      'name': name,
      'type': type,
      'amount': amount,
      'unit': unit,
      'lastDate': lastDate,
      'description': description,
      'normalPrice': normalPrice,
      'discountPrice': discountPrice,
    };
  }
}
