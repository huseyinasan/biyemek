import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../services/my_products_service.dart';
import '../../../widgets/my_products_item.dart';

class MyProductsPage extends StatefulWidget {
  final String businessUid;
  const MyProductsPage({
    Key? key,
    required this.businessUid,
  }) : super(key: key);

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
        ],
        title: const Text(
          "Ürünlerim",
          style: TextStyle(
            color: Colors.green,
          ),
        ),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        iconTheme: const IconThemeData(
          color: Colors.green,
        ),
        backgroundColor: const Color(0xFFEDECF5),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.green, width: 2.0),
              insets: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            controller: _tabController,
            tabs: const [
              Tab(
                child: Text(
                  "İlandakiler",
                  style: TextStyle(color: Colors.green),
                ),
              ),
              Tab(
                child: Text(
                  "Satılanlar",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                //products will come here
                Center(
                  child: StreamBuilder<List<Product>>(
                    stream: ProductService().getMyProducts(widget.businessUid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Bir şeyler yanlış gitti'));
                      } else if (snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return Center(
                            child: Text('Herhangi bir ürün bulunamadı.'));
                      } else {
                        return ListView.builder(
                          padding: const EdgeInsets.all(10.0),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (ctx, i) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: ProductItem(
                              product: snapshot.data![i],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Center(child: Text('İçerik 2')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
