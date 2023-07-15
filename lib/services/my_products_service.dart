import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:biyemek/models/product_model.dart';

class ProductService {
  Stream<List<Product>> getMyProducts(String businessUid) {
    return FirebaseFirestore.instance
        .collection('products')
        .where('businessUid', isEqualTo: businessUid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList());
  }
}
