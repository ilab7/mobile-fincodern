// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int? id;
  String? fullname;
  String? email;
  String? image;
  String? phone;
  String? token;

  UserModel({
    this.id,
    this.fullname,
    this.email,
    this.image,
    this.phone,
    this.token,
  });

  factory UserModel.fromJson(Map json) => UserModel(
    id: json["id"],
    fullname: json["name"],
    email: json["email"],
    image: json["image"],
    phone: json["phone"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": fullname,
    "email": email,
    "image": image,
    "phone": phone,
    "token": token,
  };
}
