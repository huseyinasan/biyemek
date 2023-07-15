import 'package:biyemek/models/product_model.dart';
import 'package:flutter/material.dart';
import '../services/category_product_service.dart';
import 'category_products_item.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    super.key,
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StreamBuilder<List<Product>>(
          stream: CategoryProductsService().getProducts(category),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Bir şeyler yanlış gitti'));
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(child: Text('Herhangi bir ürün bulunamadı.'));
            } else {
              return Expanded(
                // Wrap your ListView with Expanded
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis
                        .horizontal, // This makes your ListView scrollable horizontally
                    itemBuilder: (ctx, i) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      child: CategoryProductItem(
                        product: snapshot.data![i],
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
