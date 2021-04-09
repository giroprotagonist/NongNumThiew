import 'package:flutter/material.dart';
import 'package:nongnumtheiw/models/shop_model.dart';

class ReadQrCode extends StatefulWidget {
  final List<ShopModel> shopModels;
  ReadQrCode({@required this.shopModels});
  @override
  _ReadQrCodeState createState() => _ReadQrCodeState();
}

class _ReadQrCodeState extends State<ReadQrCode> {
  List<ShopModel> shopModels;
  @override
  void initState() {
    super.initState();
    shopModels = widget.shopModels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Read QR code'),
    );
  }
}
