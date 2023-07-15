import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:biyemek/models/product_model.dart';

class CategoryProductsService {
  final _productsRef = FirebaseFirestore.instance.collection('products');

  Stream<List<Product>> getProducts(String type) {
    return _productsRef.where('type', isEqualTo: type).snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList());
  }

  //sepete ekleme özelliği eklenecek
  //cart collectionun altında uid document olacak
  //document altında ürünün uid'si olacak
  // Future<void> addToCart(String productId) {
  //   return _productsRef.doc(productId).delete();
  // }
}
