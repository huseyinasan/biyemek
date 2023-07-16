import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:biyemek/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomerProductsService {
  final _cartProductsRef = FirebaseFirestore.instance.collection('products');

  //getting the category method
  Stream<List<Product>> getProducts(String type) {
    return _cartProductsRef.where('type', isEqualTo: type).snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList());
  }

  //adding to cart method
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

  //getting from cart method
  Stream<List<Product>> getCartProducts() async* {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final cartRef =
          FirebaseFirestore.instance.collection('cart').doc(user.uid);
      final doc = await cartRef.get();
      List<Product> products = [];

      if (doc.exists) {
        List<dynamic> productIds = doc.data()?['products'] ?? [];
        for (String productId in productIds) {
          final productDoc = await _cartProductsRef.doc(productId).get();
          if (productDoc.exists) {
            var data = productDoc.data();
            if (data != null) {
              products.add(Product.fromMap(data));
            }
          }
        }
      }

      yield products;
    }
  }

  //removing from cart method
  Future<String> removeFromCart(String productId) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final cartRef =
          FirebaseFirestore.instance.collection('cart').doc(user.uid);
      final doc = await cartRef.get();

      if (doc.exists) {
        List<dynamic> products = doc.data()?['products'] ?? [];

        if (products.contains(productId)) {
          await cartRef.update(
            {
              'products': FieldValue.arrayRemove([productId])
            },
          );
          return 'Ürün sepetinizden çıkarıldı.';
        } else {
          return 'Bu ürün sepetinizde bulunamadı.';
        }
      } else {
        return 'Sepetinizde hiç ürün bulunmamaktadır.';
      }
    } else {
      return 'Giriş yapmış bir kullanıcı değilsiniz.';
    }
  }

  Future<double> getTotalNormalPrice() async {
    final user = FirebaseAuth.instance.currentUser;
    double totalNormalPrice = 0.0;

    if (user != null) {
      final cartRef =
          FirebaseFirestore.instance.collection('cart').doc(user.uid);
      final doc = await cartRef.get();

      if (doc.exists) {
        List<dynamic> productIds = doc.data()?['products'] ?? [];
        for (String productId in productIds) {
          final productDoc = await _cartProductsRef.doc(productId).get();
          if (productDoc.exists) {
            var data = productDoc.data();
            if (data != null) {
              Product product = Product.fromMap(data);
              totalNormalPrice += product
                  .normalPrice; // assuming your price field is called normalPrice
            }
          }
        }
      }
    }

    return totalNormalPrice;
  }

  Future<double> getTotalDiscountPrice() async {
    final user = FirebaseAuth.instance.currentUser;
    double totalDiscountPrice = 0.0;

    if (user != null) {
      final cartRef =
          FirebaseFirestore.instance.collection('cart').doc(user.uid);
      final doc = await cartRef.get();

      if (doc.exists) {
        List<dynamic> productIds = doc.data()?['products'] ?? [];
        for (String productId in productIds) {
          final productDoc = await _cartProductsRef.doc(productId).get();
          if (productDoc.exists) {
            var data = productDoc.data();
            if (data != null) {
              Product product = Product.fromMap(data);
              totalDiscountPrice += product
                  .discountPrice; // assuming your price field is called discountPrice
            }
          }
        }
      }
    }

    return totalDiscountPrice;
  }

  // Method to copy products from the cart to the orders collection
  Future<void> orderProduct() async {
    final user = FirebaseAuth.instance.currentUser;
    final _productsRef = FirebaseFirestore.instance.collection('products');
    final _oldProductsRef =
        FirebaseFirestore.instance.collection('oldProducts');

    if (user != null) {
      final cartRef =
          FirebaseFirestore.instance.collection('cart').doc(user.uid);
      final orderRef =
          FirebaseFirestore.instance.collection('order').doc(user.uid);

      final doc = await cartRef.get();

      if (doc.exists) {
        List<dynamic> products = doc.data()?['products'] ?? [];

        await orderRef.set({'products': products});

        // Move the product from 'products' to 'oldProducts' and remove it from 'products'
        for (String productId in products) {
          final productDoc = await _productsRef.doc(productId).get();
          if (productDoc.exists) {
            var data = productDoc.data();
            if (data != null) {
              // copy the product to 'oldProducts'
              await _oldProductsRef.doc(productId).set(data);
              // remove the product from 'products'
              await _productsRef.doc(productId).delete();
            }
          }
        }

        // Clear the cart after copying its contents to the order
        await cartRef.delete();
      }
    }
  }

  Stream<List<Product>> getOrderProducts() async* {
    final user = FirebaseAuth.instance.currentUser;
    final oldProductsRef = FirebaseFirestore.instance.collection('oldProducts');

    if (user != null) {
      final orderRef =
          FirebaseFirestore.instance.collection('order').doc(user.uid);
      final doc = await orderRef.get();
      List<Product> products = [];

      if (doc.exists) {
        List<dynamic> productIds = doc.data()?['products'] ?? [];
        for (String productId in productIds) {
          final productDoc = await oldProductsRef.doc(productId).get();
          if (productDoc.exists) {
            var data = productDoc.data();
            if (data != null) {
              products.add(Product.fromMap(data));
            }
          }
        }
      }

      yield products;
    }
  }
}
