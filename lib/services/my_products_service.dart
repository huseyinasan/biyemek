import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:biyemek/models/product_model.dart';

class ProductService {
  final _productsRef = FirebaseFirestore.instance.collection('products');

  Stream<List<Product>> getMyProducts(String businessUid) {
    return _productsRef
        .where('businessUid', isEqualTo: businessUid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList());
  }

  Future<void> deleteProduct(String productId) {
    return _productsRef.doc(productId).delete();
  }
}
