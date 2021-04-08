import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nongnumtheiw/utility/my_style.dart';
import 'package:nongnumtheiw/widgets/show_progress.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  double size;
  String name,
      detail,
      address,
      phone,
      image1,
      image2,
      image3,
      image4,
      image5,
      user,
      password;
  double lat, lng;
  Map<MarkerId, Marker> mapMarker = {};

  @override
  void initState() {
    super.initState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    await findPosition().then((value) {
      setState(() {
        lat = value.latitude;
        lng = value.longitude;
        // print('#### lat = $lat, lng = $lng');
        addMarkers(LatLng(lat, lng));
      });
    });
  }

  void addMarkers(LatLng latLng) {
    MarkerId markerId = MarkerId('id');
    Marker marker = Marker(
        markerId: markerId,
        position: latLng,
        infoWindow: InfoWindow(
          title: 'You Here ?',
          snippet: 'lat = $lat, lng = $lng',
        ));
    setState(() {
      mapMarker[markerId] = marker;
    });
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

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primary,
        title: Text('Create New Account'),
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                buildSizedBox(),
                buildName(),
                buildDetail(),
                buildAddress(),
                buildPhone(),
                buildUser(),
                buildPassword(),
                buildImage(),
                buildControlPanelImage(),
                buildShowMap(),
                buildElevatedButton(),
                buildSizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: MyStyle().primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        icon: Icon(Icons.cloud_upload),
        label: Text('Create New Account'));
  }

  Container buildShowMap() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24),
      width: size * 0.8,
      height: size * 0.6,
      child: lat == null
          ? ShowProgress()
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, lng),
                zoom: 16,
              ),
              onMapCreated: (controller) {},
              markers: Set<Marker>.of(mapMarker.values),
            ),
    );
  }

  SizedBox buildSizedBox() {
    return SizedBox(
      height: 50,
    );
  }

  Container buildControlPanelImage() {
    return Container(
      width: size * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: Icon(
                Icons.filter_1,
                size: 48,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.filter_2,
                size: 48,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.filter_3,
                size: 48,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.filter_4,
                size: 48,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.filter_5,
                size: 48,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }

  Container buildImage() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: size * 0.8,
      height: size * 0.8,
      child: Image.asset('images/image.png'),
    );
  }

  Container buildName() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: TextFormField(
        onChanged: (value) => name = value.trim(),
        style: MyStyle().darkNormalStyle(),
        decoration: InputDecoration(
          labelStyle: MyStyle().darkNormalStyle(),
          labelText: 'Display Name :',
          prefixIcon: Icon(
            Icons.fingerprint,
            color: MyStyle().dark,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().dark)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().light)),
        ),
      ),
    );
  }

  Container buildDetail() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: TextFormField(
        onChanged: (value) => detail = value.trim(),
        style: MyStyle().darkNormalStyle(),
        decoration: InputDecoration(
          labelStyle: MyStyle().darkNormalStyle(),
          labelText: 'Detail :',
          prefixIcon: Icon(
            Icons.details,
            color: MyStyle().dark,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().dark)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().light)),
        ),
      ),
    );
  }

  Container buildAddress() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: TextFormField(
        onChanged: (value) => name = value.trim(),
        style: MyStyle().darkNormalStyle(),
        decoration: InputDecoration(
          labelStyle: MyStyle().darkNormalStyle(),
          labelText: 'Address :',
          prefixIcon: Icon(
            Icons.home,
            color: MyStyle().dark,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().dark)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().light)),
        ),
      ),
    );
  }

  Container buildPhone() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: TextFormField(
        onChanged: (value) => name = value.trim(),
        style: MyStyle().darkNormalStyle(),
        decoration: InputDecoration(
          labelStyle: MyStyle().darkNormalStyle(),
          labelText: 'Phone :',
          prefixIcon: Icon(
            Icons.phone,
            color: MyStyle().dark,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().dark)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().light)),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: TextFormField(
        onChanged: (value) => name = value.trim(),
        style: MyStyle().darkNormalStyle(),
        decoration: InputDecoration(
          labelStyle: MyStyle().darkNormalStyle(),
          labelText: 'User :',
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyStyle().dark,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().dark)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().light)),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: TextFormField(
        onChanged: (value) => name = value.trim(),
        style: MyStyle().darkNormalStyle(),
        decoration: InputDecoration(
          labelStyle: MyStyle().darkNormalStyle(),
          labelText: 'Password :',
          prefixIcon: Icon(
            Icons.lock_outline,
            color: MyStyle().dark,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().dark)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: MyStyle().light)),
        ),
      ),
    );
  }
}
