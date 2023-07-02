import 'package:flutter/material.dart';
class notifications extends StatefulWidget {
  const notifications({Key? key}) : super(key: key);

  @override
  State<notifications> createState() => _notificationsState();
}

class _notificationsState extends State<notifications> with SingleTickerProviderStateMixin {
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
        actions: [

        ],
        title: const Text(
          "Bildirimler",
          style: TextStyle(
            color: Colors.green,
          ),
        ),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),),

        iconTheme: const IconThemeData(
          color: Colors.green,
        ),


        backgroundColor: const Color(0xFFEDECF5),

      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Cevap Bekleyenler',
              ),
              Tab(text: 'Cevaplananlar'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
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
