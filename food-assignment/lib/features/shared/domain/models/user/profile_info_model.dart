// To parse this JSON data, do
//
//     final profileInfoResponse = profileInfoResponseFromJson(jsonString);

import 'dart:convert';

ProfileInfoResponse profileInfoResponseFromJson(String str) => ProfileInfoResponse.fromJson(json.decode(str));

String profileInfoResponseToJson(ProfileInfoResponse data) => json.encode(data.toJson());

class ProfileInfoResponse {
  bool? success;
  String? msg;
  Data? data;

  ProfileInfoResponse({
    this.success,
    this.msg,
    this.data,
  });

  factory ProfileInfoResponse.fromJson(Map<String, dynamic> json) => ProfileInfoResponse(
    success: json["success"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? name;
  String? email;
  String? mobile_no;
  String? image;

  Data({
    this.id,
    this.email,
    this.name,
    this.mobile_no,
    this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    mobile_no: json["mobile_no"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "mobile_no": mobile_no,
    "image": image,
  };
}
