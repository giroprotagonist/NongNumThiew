import 'package:flutter/material.dart';
import 'package:nongnumtheiw/models/shop_model.dart';

class ShowMap extends StatefulWidget {
  final List<ShopModel> shopModels;
  ShowMap({@required this.shopModels});
  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  List<ShopModel> shopModels;
  @override
  void initState() {
    super.initState();
    shopModels = widget.shopModels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Show Map'),
    );
  }
}
