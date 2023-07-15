import 'package:flutter/material.dart';
import 'package:biyemek/models/product_model.dart';

class CategoryProductItem extends StatelessWidget {
  final Product product;

  const CategoryProductItem({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5.0,
      child: SizedBox(
        height: 250,
        width: 200,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                product.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fiyat: ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "${product.normalPrice.toString()} ₺",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        decoration: TextDecoration.lineThrough),
                  ),
                  Text(
                    "  >  ${product.discountPrice.toString()} ₺",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
