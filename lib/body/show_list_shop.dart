import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nongnumtheiw/models/shop_model.dart';
import 'package:nongnumtheiw/utility/my_style.dart';
import 'package:nongnumtheiw/widgets/show_logo.dart';
import 'package:nongnumtheiw/widgets/show_progress.dart';

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
      body: ListView.builder(
        itemCount: shopModels.length,
        itemBuilder: (context, index) => Container(
          height: 150,
          child: Card(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            shopModels[index].urlImages[0],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          shopModels[index].name,
                          style: MyStyle().darkH1Style(),
                        ),
                        Text(cutText(shopModels[index].detail))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String cutText(String detail) {
    String result = detail;
    if (result.length > 100) {
      result = result.substring(0, 100);
      result = '$result ... ';
    }
    return result;
  }
}
