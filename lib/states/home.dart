import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(tooltip: 'Authen',
            icon: Icon(Icons.account_circle_outlined),
            onPressed: () => Navigator.pushNamed(context, '/authen'),
          )
        ],
      ),
    );
  }
}
