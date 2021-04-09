import 'dart:convert';

import 'package:flutter/foundation.dart';

class ShopModel {
  final String uid;
  final String name;
  final String type;
  final String detail;
  final String address;
  final String phone;
  final String email;
  final String password;
  final double lat;
  final double lng;
  final List<String> urlImages;
  ShopModel({
    this.uid,
    this.name,
    this.type,
    this.detail,
    this.address,
    this.phone,
    this.email,
    this.password,
    this.lat,
    this.lng,
    this.urlImages,
  });

  ShopModel copyWith({
    String uid,
    String name,
    String type,
    String detail,
    String address,
    String phone,
    String email,
    String password,
    double lat,
    double lng,
    List<String> urlImages,
  }) {
    return ShopModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      type: type ?? this.type,
      detail: detail ?? this.detail,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      urlImages: urlImages ?? this.urlImages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'type': type,
      'detail': detail,
      'address': address,
      'phone': phone,
      'email': email,
      'password': password,
      'lat': lat,
      'lng': lng,
      'urlImages': urlImages,
    };
  }

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      uid: map['uid'],
      name: map['name'],
      type: map['type'],
      detail: map['detail'],
      address: map['address'],
      phone: map['phone'],
      email: map['email'],
      password: map['password'],
      lat: map['lat'],
      lng: map['lng'],
      urlImages: List<String>.from(map['urlImages']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopModel.fromJson(String source) => ShopModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShopModel(uid: $uid, name: $name, type: $type, detail: $detail, address: $address, phone: $phone, email: $email, password: $password, lat: $lat, lng: $lng, urlImages: $urlImages)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ShopModel &&
      other.uid == uid &&
      other.name == name &&
      other.type == type &&
      other.detail == detail &&
      other.address == address &&
      other.phone == phone &&
      other.email == email &&
      other.password == password &&
      other.lat == lat &&
      other.lng == lng &&
      listEquals(other.urlImages, urlImages);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      name.hashCode ^
      type.hashCode ^
      detail.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      email.hashCode ^
      password.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      urlImages.hashCode;
  }
}
