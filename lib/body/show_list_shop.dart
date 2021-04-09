import 'package:flutter/material.dart';
import 'package:nongnumtheiw/models/shop_model.dart';

class ShowListShop extends StatefulWidget {
  final List<ShopModel> shopModels;
  ShowListShop({@required this.shopModels});
  @override
  _ShowListShopState createState() => _ShowListShopState();
}

class _ShowListShopState extends State<ShowListShop> {
  List<ShopModel> shopModels;
  @override
  void initState() {
    super.initState();
    shopModels = widget.shopModels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Show List Shop'),
    );
  }
}
