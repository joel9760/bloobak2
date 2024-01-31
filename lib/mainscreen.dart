import 'package:bloobak/screen1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Donors',style:TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push( context,MaterialPageRoute(builder: (context)=>Screen1()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}