import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nongnumtheiw/body/read_qr_code.dart';
import 'package:nongnumtheiw/body/show_list_shop.dart';
import 'package:nongnumtheiw/body/show_map.dart';
import 'package:nongnumtheiw/models/shop_model.dart';
import 'package:nongnumtheiw/utility/my_style.dart';
import 'package:nongnumtheiw/widgets/show_progress.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ShopModel> shopModels = [];
  List<Widget> widgets = [];
  int index = 0;
  List<String> titles = ['Show List Shop', 'Show Map', 'Read QRcode'];

  bool locationServiceEnable;
  LocationPermission locationPermission;
  LatLng latLng;
  

  @override
  void initState() {
    super.initState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    locationPermission = await Geolocator.checkPermission();
    // print('================================================');
    // print(' permission ==> $locationPermission ');
    // print('================================================');

    switch (locationPermission) {
      case LocationPermission.denied:
        await Geolocator.requestPermission().then((value) async {
          if (value == LocationPermission.deniedForever) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/deniedForever', (route) => false);
          } else {
            var position = await findPosition();
            latLng = LatLng(position.latitude, position.longitude);
            readData();
          }
        });
        break;
      case LocationPermission.deniedForever:
        Navigator.pushNamedAndRemoveUntil(
            context, '/deniedForever', (route) => false);
        break;
      default:
        var position = await findPosition();
        latLng = LatLng(position.latitude, position.longitude);
        readData();
    }
  }

  Future<Position> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection('user')
          .snapshots()
          .listen((event) {
        for (var item in event.docs) {
          ShopModel model = ShopModel.fromMap(item.data());
          setState(() {
            shopModels.add(model);
            print('nameShop ==> ${model.name}');
          });
        }
        widgets.add(ShowListShop(shopModels: shopModels));
        widgets.add(ShowMap(
          shopModels: shopModels,
          latLng: latLng,
        ));
        widgets.add(ReadQrCode(
          shopModels: shopModels,
        ));
      });
    });
  }

  List<BottomNavigationBarItem> bottonNavigationBarItem() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.store),
        label: titles[0],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.map),
        label: titles[1],
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.qr_code_scanner),
        label: titles[2],
      ),
    ].toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primary,
        title: Text(titles[index]),
        actions: [buildIAuthen(context)],
      ),
      body: shopModels.length == 0 ? ShowProgress() : widgets[index],
      bottomNavigationBar: BottomNavigationBar(
        items: bottonNavigationBarItem(),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: MyStyle().primary,
        iconSize: 48,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }

  IconButton buildIAuthen(BuildContext context) {
    return IconButton(
      tooltip: 'Authen',
      icon: Icon(Icons.account_circle_outlined),
      onPressed: () => Navigator.pushNamed(context, '/authen'),
    );
  }
}
