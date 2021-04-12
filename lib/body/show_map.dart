import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nongnumtheiw/models/shop_model.dart';
import 'package:nongnumtheiw/states/detail_shop.dart';
import 'package:nongnumtheiw/utility/normal_dialog.dart';
import 'package:nongnumtheiw/widgets/show_logo.dart';
import 'package:nongnumtheiw/widgets/show_progress.dart';

class ShowMap extends StatefulWidget {
  final List<ShopModel> shopModels;
  final LatLng latLng;
  ShowMap({@required this.shopModels, @required this.latLng});
  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  List<ShopModel> shopModels;
  LatLng latlng;
  Map<MarkerId, Marker> markers = {};

  @override
  void initState() {
    super.initState();
    shopModels = widget.shopModels;
    latlng = widget.latLng;
    createAllMarker();
  }

  void createAllMarker() {
    addMarker(latlng, 'idUser', BitmapDescriptor.defaultMarker, 'You Here');

    for (var item in shopModels) {
      addMarker(LatLng(item.lat, item.lng), item.uid,
          BitmapDescriptor.defaultMarkerWithHue(90), item.name,
          shopModel: item);
    }
  }

  void addMarker(LatLng mylatLng, String id, BitmapDescriptor bitmapDescriptor,
      String title,
      {ShopModel shopModel}) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: bitmapDescriptor,
      position: mylatLng,
      onTap: () {
        if (title != 'You Here') {
          // normalDialog(context, title, 'You Tab Marker id => $id');
          markerDialog(shopModel);
        }
      },
      infoWindow: InfoWindow(title: title),
    );
    markers[markerId] = marker;
  }

  Future<Null> markerDialog(ShopModel shopModel) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: CachedNetworkImage(
            imageUrl: shopModel.urlImages[0],
            placeholder: (context, url) => ShowProgress(),
            errorWidget: (context, url, error) => ShowLogo(),
          ),
          title: Text(shopModel.name),
          subtitle: Text(cutText(shopModel.detail)),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailShop(shopModel: shopModel),
                      ));
                },
                child: Text('More Detail'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red.shade700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String cutText(String detail) {
    String result = detail;
    if (result.length > 70) {
      result = result.substring(0, 70);
      result = '$result ... ';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: latlng,
          zoom: 16,
        ),
        onMapCreated: (controller) {},
        markers: Set<Marker>.of(markers.values),
      ),
    );
  }
}
