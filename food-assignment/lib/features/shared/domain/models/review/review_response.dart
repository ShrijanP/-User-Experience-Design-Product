// import 'dart:convert';
//
// ReviewResponse reviewResponseFromJson(String str) => ReviewResponse.fromJson(json.decode(str));
//
// String reviewResponseToJson(ReviewResponse data) => json.encode(data.toJson());
//
// class ReviewResponse {
//   bool? success;
//   String? msg;
//   List<ReviewDatum>? data;
//
//   ReviewResponse({
//     this.success,
//     this.msg,
//     this.data,
//   });
//
//   factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
//     success: json["success"],
//     msg: json["msg"],
//     data: List<ReviewDatum>.from(json["data"].map((x) => ReviewDatum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "msg": msg,
//     "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class ReviewDatum {
//   String? id;
//   String? product;
//   User? user;
//   int? rating;
//   String? message;
//   DateTime? updatedAt;
//   DateTime? createdAt;
//   int? v;
//
//   ReviewDatum({
//     this.id,
//     this.product,
//     this.user,
//     this.rating,
//     this.message,
//     this.updatedAt,
//     this.createdAt,
//     this.v,
//   });
//
//   factory ReviewDatum.fromJson(Map<String, dynamic> json) => ReviewDatum(
//     id: json["_id"],
//     product: json["product"],
//     user: User.fromJson(json["user"]),
//     rating: json["rating"],
//     message: json["message"],
//     updatedAt: DateTime.parse(json["updatedAt"]),
//     createdAt: DateTime.parse(json["createdAt"]),
//     v: json["__v"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "product": product,
//     "user": user?.toJson(),
//     "rating": rating,
//     "message": message,
//     "updatedAt": updatedAt?.toIso8601String(),
//     "createdAt": createdAt?.toIso8601String(),
//     "__v": v,
//   };
// }
//
// class User {
//   String? id;
//   String? firstname;
//   String? lastname;
//   String? email;
//   int? contact;
//   String? address;
//   List<String>? role;
//   bool? isDeleted;
//
//   User({
//     this.id,
//     this.firstname,
//     this.lastname,
//     this.email,
//     this.contact,
//     this.address,
//     this.role,
//     this.isDeleted,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//     id: json["_id"],
//     firstname: json["firstname"],
//     lastname: json["lastname"],
//     email: json["email"],
//     contact: json["contact"],
//     address: json["address"],
//     role: List<String>.from(json["role"].map((x) => x)),
//     isDeleted: json["is_deleted"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "firstname": firstname,
//     "lastname": lastname,
//     "email": email,
//     "contact": contact,
//     "address": address,
//     "role": List<dynamic>.from(role!.map((x) => x)),
//     "is_deleted": isDeleted,
//   };
// }

// To parse this JSON data, do
//
//     final reviewResponse = reviewResponseFromJson(jsonString);

import 'dart:convert';

ReviewResponse reviewResponseFromJson(String str) =>
    ReviewResponse.fromJson(json.decode(str));

String reviewResponseToJson(ReviewResponse data) => json.encode(data.toJson());

class ReviewResponse {
  bool? success;
  String? msg;
  List<ReviewDatum>? data;

  ReviewResponse({
    this.success,
    this.msg,
    this.data,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
        success: json["success"],
        msg: json["msg"],
        data: List<ReviewDatum>.from(
            json["data"].map((x) => ReviewDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ReviewDatum {
  String? id;
  String? product;
  User? user;
  num? rating;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ReviewDatum({
    this.id,
    this.product,
    this.user,
    this.rating,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ReviewDatum.fromJson(Map<String, dynamic> json) => ReviewDatum(
        id: json["_id"],
        product: json["product"],
        user: User.fromJson(json["user"]),
        rating: json["rating"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product": product,
        "user": user?.toJson(),
        "rating": rating,
        "message": message,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class User {
  String? id;
  String? name;
  String? email;
  String? mobileNo;
  String? role;

  User({
    this.id,
    this.name,
    this.email,
    this.mobileNo,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        mobileNo: json["mobile_no"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "mobile_no": mobileNo,
        "role": role,
      };
}
