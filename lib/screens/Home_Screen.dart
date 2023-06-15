import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext){
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Screen"),
      centerTitle: true,
      ),
          body: const Center(
        child: Text("First Screen ",style: TextStyle(fontSize: 25),),
    ),
    );
  }
}