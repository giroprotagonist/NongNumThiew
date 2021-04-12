import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nongnumtheiw/models/shop_model.dart';
import 'package:nongnumtheiw/utility/my_style.dart';
import 'package:nongnumtheiw/widgets/show_logo.dart';
import 'package:nongnumtheiw/widgets/show_progress.dart';

class DetailShop extends StatefulWidget {
  final ShopModel shopModel;
  DetailShop({@required this.shopModel});
  @override
  _DetailShopState createState() => _DetailShopState();
}

class _DetailShopState extends State<DetailShop> {
  ShopModel shopModel;
  double size;
  String urlShowImage;

  @override
  void initState() {
    super.initState();
    shopModel = widget.shopModel;
    urlShowImage = shopModel.urlImages[0];
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primary,
        title: Text(shopModel.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
                  child: Column(
            children: [
              buildName(),
              buildAddress(),
              buildPhone(),
              buildEmail(),
              buildimage(),
              buildControlPanel(),
              buildDetail(),
            ],
          ),
        ),
      ),
    );
  }

  Container buildControlPanel() {
    return Container(
            width: size * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  child: GestureDetector(
                    onTap: () => changeImage(shopModel.urlImages[0]),
                    child: CachedNetworkImage(
                      imageUrl: shopModel.urlImages[0],
                      placeholder: (context, url) => ShowProgress(),
                      errorWidget: (context, url, error) => ShowLogo(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 48,
                  height: 48,
                  child: GestureDetector(
                    onTap: () => changeImage(shopModel.urlImages[1]),
                    child: CachedNetworkImage(
                      imageUrl: shopModel.urlImages[1],
                      placeholder: (context, url) => ShowProgress(),
                      errorWidget: (context, url, error) => ShowLogo(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 48,
                  height: 48,
                  child: GestureDetector(
                    onTap: () => changeImage(shopModel.urlImages[2]),
                    child: CachedNetworkImage(
                      imageUrl: shopModel.urlImages[2],
                      placeholder: (context, url) => ShowProgress(),
                      errorWidget: (context, url, error) => ShowLogo(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 48,
                  height: 48,
                  child: GestureDetector(
                    onTap: () => changeImage(shopModel.urlImages[3]),
                    child: CachedNetworkImage(
                      imageUrl: shopModel.urlImages[3],
                      placeholder: (context, url) => ShowProgress(),
                      errorWidget: (context, url, error) => ShowLogo(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 48,
                  height: 48,
                  child: GestureDetector(
                    onTap: () => changeImage(shopModel.urlImages[4]),
                    child: CachedNetworkImage(
                      imageUrl: shopModel.urlImages[4],
                      placeholder: (context, url) => ShowProgress(),
                      errorWidget: (context, url, error) => ShowLogo(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  void changeImage(String urlPath) {
    setState(() {
      urlShowImage = urlPath;
    });
  }

  Container buildimage() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: size * 0.9,
      height: size * 0.6,
      child: CachedNetworkImage(
        imageUrl: urlShowImage,
        placeholder: (context, url) => ShowProgress(),
        errorWidget: (context, url, error) => ShowLogo(),
      ),
    );
  }

  Row buildName() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Name :',
            style: MyStyle().darkH2Style(),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            shopModel.name,
            style: MyStyle().darkH3Style(),
          ),
        ),
      ],
    );
  }

  Row buildAddress() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Address :',
            style: MyStyle().darkH2Style(),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            shopModel.address,
            style: MyStyle().darkH3Style(),
          ),
        ),
      ],
    );
  }

  Row buildPhone() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Phone :',
            style: MyStyle().darkH2Style(),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            shopModel.phone,
            style: MyStyle().darkH3Style(),
          ),
        ),
      ],
    );
  }

  Row buildEmail() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Email :',
            style: MyStyle().darkH2Style(),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            shopModel.email,
            style: MyStyle().darkH3Style(),
          ),
        ),
      ],
    );
  }

  Widget buildDetail() {
    return Container(margin: EdgeInsets.symmetric(vertical: 16),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              'Detail :',
              style: MyStyle().darkH2Style(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              shopModel.detail,
              style: MyStyle().darkH3Style(),
            ),
          ),
        ],
      ),
    );
  }
}
