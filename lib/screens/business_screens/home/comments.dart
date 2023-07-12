import 'package:flutter/material.dart';

class Comments extends StatefulWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments>
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
        title: const Text(
          "Yorumlar",
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
              borderSide: BorderSide(
                  color: Colors.green,
                  width: 2.0), // Çizginin rengi ve kalınlığı
              insets: EdgeInsets.symmetric(
                  horizontal: 16.0), // Çizginin tablerle olan boşluğu
            ),
            controller: _tabController,
            tabs: const [
              Tab(
                child: Text(
                  "Cevap Bekleyenler",
                  style: TextStyle(color: Colors.green),
                ),
              ),
              Tab(
                child: Text(
                  "Cevaplanlar",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Center(child: Text('Yorumlar 1 (sağa kaydır)')),
                Center(child: Text('Yorumlar 2')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
