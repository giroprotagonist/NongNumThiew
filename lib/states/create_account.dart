import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nongnumtheiw/models/shop_model.dart';
import 'package:nongnumtheiw/utility/my_style.dart';
import 'package:nongnumtheiw/utility/normal_dialog.dart';
import 'package:nongnumtheiw/widgets/show_logo.dart';
import 'package:nongnumtheiw/widgets/show_progress.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  double size;
  String name, detail, address, phone, user, password, uid;
  List<File> files = [];
  List<String> urlImages = [];
  double lat, lng;
  Map<MarkerId, Marker> mapMarker = {};
  File file;

  @override
  void initState() {
    super.initState();
    findLatLng();

    for (var i = 0; i < 5; i++) {
      files.add(null);
    }
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

  Future<Null> uploadImageAnCreateAccount() async {
    await Firebase.initializeApp().then((value) async {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user, password: password)
          .then((value) async {
        uid = value.user.uid;
        await value.user.updateProfile(displayName: name);

        for (var item in files) {
          int i = Random().nextInt(1000000);
          String nameFile = uid.substring(0, 4);
          nameFile = '$nameFile$i.jpg';

          Reference reference =
              FirebaseStorage.instance.ref().child('shop/$nameFile');
          UploadTask uploadTask = reference.putFile(item);
          await uploadTask.whenComplete(() async {
            await reference.getDownloadURL().then((value) {
              if (value?.isNotEmpty ?? true) {
                urlImages.add(value);
              }
            });
          });
        }

        // print('urlImages ==> ${urlImages.toString()}');
        ShopModel model = ShopModel(
          uid: uid,
          name: name,
          type: 'shop',
          detail: detail,
          address: address,
          phone: phone,
          email: user,
          password: password,
          lat: lat,
          lng: lng,
          urlImages: urlImages,
        );
        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .set(model.toMap())
            .then((value) => Navigator.pop(context));
      }).catchError((onError) =>
              normalDialog(context, onError.code, onError.message));
    });
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: MyStyle().primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          if ((name?.isEmpty ?? true) ||
              (detail?.isEmpty ?? true) ||
              (address?.isEmpty ?? true) ||
              (phone?.isEmpty ?? true) ||
              (user?.isEmpty ?? true) ||
              (password?.isEmpty ?? true)) {
            normalDialog(
                context, 'Have Space ?', 'Please Fill Every Blank Not Empty !');
          } else if (checkChoose()) {
            normalDialog(context, 'Incomplete picture selection ?',
                'Please select all five pictures.');
          } else {
            uploadImageAnCreateAccount();
          }
        },
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

  Future<Null> chooseImage(ImageSource source, int index) async {
    print('file leang ==> ${files.length} You sent index ==> $index');
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        files[index] = File(result.path);
        file = files[index];
      });
    } catch (e) {}
  }

  Future<Null> chooseSourceDialog(int index) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: ShowLogo(),
          title: Text('Source Image ${index + 1} ?'),
          subtitle: Text(
              'Please Choose Sourece Image ${index + 1} from Camera or Gallery'),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  chooseImage(ImageSource.camera, index);
                },
                child: Text('Camera'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  chooseImage(ImageSource.gallery, index);
                },
                child: Text('Gallery'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
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

  Container buildControlPanelImage() {
    return Container(
      width: size * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: Icon(
                files[0] == null ? Icons.filter_1 : Icons.check_box,
                size: 48,
              ),
              onPressed: () {
                if (files[0] == null) {
                  chooseSourceDialog(0);
                } else {
                  setState(() {
                    file = files[0];
                  });
                }
              }),
          IconButton(
              icon: Icon(
                files[1] == null ? Icons.filter_2 : Icons.check_box,
                size: 48,
              ),
              onPressed: () {
                if (files[1] == null) {
                  chooseSourceDialog(1);
                } else {
                  setState(() {
                    file = files[1];
                  });
                }
              }),
          IconButton(
              icon: Icon(
                files[2] == null ? Icons.filter_3 : Icons.check_box,
                size: 48,
              ),
              onPressed: () {
                if (files[2] == null) {
                  chooseSourceDialog(2);
                } else {
                  setState(() {
                    file = files[2];
                  });
                }
              }),
          IconButton(
              icon: Icon(
                files[3] == null ? Icons.filter_4 : Icons.check_box,
                size: 48,
              ),
              onPressed: () {
                if (files[3] == null) {
                  chooseSourceDialog(3);
                } else {
                  setState(() {
                    file = files[3];
                  });
                }
              }),
          IconButton(
              icon: Icon(
                files[4] == null ? Icons.filter_5 : Icons.check_box,
                size: 48,
              ),
              onPressed: () {
                if (files[4] == null) {
                  chooseSourceDialog(4);
                } else {
                  setState(() {
                    file = files[4];
                  });
                }
              }),
        ],
      ),
    );
  }

  Container buildImage() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: size * 0.8,
      height: size * 0.8,
      child: file == null ? Image.asset('images/image.png') : Image.file(file),
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
        onChanged: (value) => address = value.trim(),
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
        keyboardType: TextInputType.phone,
        onChanged: (value) => phone = value.trim(),
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
        onChanged: (value) => user = value.trim(),
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
        onChanged: (value) => password = value.trim(),
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

  bool checkChoose() {
    bool result = false;
    for (var item in files) {
      if (item == null) {
        result = true;
      }
    }
    return result;
  }
}
