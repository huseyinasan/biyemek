import 'package:flutter/material.dart';
import 'package:biyemek/models/product_model.dart';
import '../screens/customer_screens/home/product/product_details_page.dart';
import '../services/customer_product_service.dart';
import 'category_products_item.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StreamBuilder<List<Product>>(
          stream: CustomerProductsService().getProducts(category),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Bir şeyler yanlış gitti'));
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(child: Text('Herhangi bir ürün bulunamadı.'));
            } else {
              return Expanded(
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (ctx, i) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsPage(product: snapshot.data![i]),
                          ));
                        },
                        child: CategoryProductItem(
                          product: snapshot.data![i],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
