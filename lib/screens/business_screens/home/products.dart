import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products>
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
              borderSide: BorderSide(color: Colors.green, width: 2.0), // Çizginin rengi ve kalınlığı
              insets: EdgeInsets.symmetric(horizontal: 16.0), // Çizginin tablerle olan boşluğu
            ),
            controller: _tabController,
            tabs: const [
              Tab(
                child: Text("İlandakiler",
                style: TextStyle(
                  color: Colors.green
                ),),
              ),
              Tab(child: Text("Satılanlar",
                style: TextStyle(
                    color: Colors.green
                ),),),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Center(child: Text('İçerik 1')),
                Center(child: Text('İçerik 2')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
