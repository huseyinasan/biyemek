import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:biyemek/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomerProductsService {
  final _productsRef = FirebaseFirestore.instance.collection('products');

  Stream<List<Product>> getProducts(String type) {
    return _productsRef.where('type', isEqualTo: type).snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList());
  }

  Future<String> addToCart(String productId) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final cartRef =
          FirebaseFirestore.instance.collection('cart').doc(user.uid);
      final doc = await cartRef.get();

      if (doc.exists) {
        List<dynamic> products = doc.data()?['products'] ?? [];

        if (products.contains(productId)) {
          return 'Ürün zaten sepetinizde var.';
        } else {
          await cartRef.update({
            'products': FieldValue.arrayUnion([productId])
          });
          return 'Ürün sepetinize eklendi.';
        }
      } else {
        await cartRef.set({
          'products': [productId]
        });
        return 'Ürün sepetinize eklendi';
      }
    } else {
      return 'Giriş yapmış bir kullanıcı değilsiniz.';
    }
  }
}
