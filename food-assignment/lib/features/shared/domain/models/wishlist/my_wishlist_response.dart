// // To parse this JSON data, do
// //
// //     final wishlistResponse = wishlistResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// WishlistResponse wishlistResponseFromJson(String str) => WishlistResponse.fromJson(json.decode(str));
//
// String wishlistResponseToJson(WishlistResponse data) => json.encode(data.toJson());
//
// class WishlistResponse {
//   bool? success;
//   String? msg;
//   List<Datum>? data;
//
//   WishlistResponse({
//     this.success,
//     this.msg,
//     this.data,
//   });
//
//   factory WishlistResponse.fromJson(Map<String, dynamic> json) => WishlistResponse(
//     success: json["success"],
//     msg: json["msg"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "msg": msg,
//     "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   String? id;
//   dynamic user;
//   Product? product;
//
//   Datum({
//     this.id,
//     this.user,
//     this.product,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["_id"],
//     user: json["user"],
//     product: Product.fromJson(json["product"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "user": user,
//     "product": product?.toJson(),
//   };
// }
//
// class Product {
//   String? id;
//   String? productName;
//   String? productSku;
//   dynamic variant;
//   num? price;
//   List<dynamic>? images;
//
//
//   Product({
//     this.id,
//     this.productName,
//     this.productSku,
//     this.variant,
//     this.price,
//     this.images,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["_id"],
//     productName: json["product_name"],
//     productSku: json["product_sku"],
//     variant: json["variant"],
//     price: json["price"],
//     images: List<dynamic>.from(json["images"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "product_name": productName,
//     "product_sku": productSku,
//     "variant": variant,
//     "price": price,
//     "images": List<dynamic>.from(images!.map((x) => x)),
//   };
// }
//
// // class Variant {
// //   String sku;
// //   int stock;
// //   List<VariantType> variantType;
// //   int price;
// //   List<dynamic> images;
// //   String id;
// //
// //   Variant({
// //     this.sku,
// //     this.stock,
// //     this.variantType,
// //     this.price,
// //     this.images,
// //     this.id,
// //   });
// //
// //   factory Variant.fromJson(Map<String, dynamic> json) => Variant(
// //     sku: json["sku"],
// //     stock: json["stock"],
// //     variantType: List<VariantType>.from(json["variant_type"].map((x) => VariantType.fromJson(x))),
// //     price: json["price"],
// //     images: List<dynamic>.from(json["images"].map((x) => x)),
// //     id: json["_id"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "sku": sku,
// //     "stock": stock,
// //     "variant_type": List<dynamic>.from(variantType.map((x) => x.toJson())),
// //     "price": price,
// //     "images": List<dynamic>.from(images.map((x) => x)),
// //     "_id": id,
// //   };
// // }
// //
// // class VariantType {
// //   String size;
// //   String color;
// //   String id;
// //
// //   VariantType({
// //     this.size,
// //     this.color,
// //     this.id,
// //   });
// //
// //   factory VariantType.fromJson(Map<String, dynamic> json) => VariantType(
// //     size: json["size"],
// //     color: json["color"],
// //     id: json["_id"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "size": size,
// //     "color": color,
// //     "_id": id,
// //   };
// // }
// //
// // class User {
// //   String id;
// //   String firstname;
// //   String lastname;
// //   String email;
// //   int contact;
// //
// //   User({
// //     this.id,
// //     this.firstname,
// //     this.lastname,
// //     this.email,
// //     this.contact,
// //   });
// //
// //   factory User.fromJson(Map<String, dynamic> json) => User(
// //     id: json["_id"],
// //     firstname: json["firstname"],
// //     lastname: json["lastname"],
// //     email: json["email"],
// //     contact: json["contact"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "_id": id,
// //     "firstname": firstname,
// //     "lastname": lastname,
// //     "email": email,
// //     "contact": contact,
// //   };
// // }


// To parse this JSON data, do
//
//     final wishlistResponse = wishlistResponseFromJson(jsonString);

import 'dart:convert';

WishlistResponse wishlistResponseFromJson(String str) => WishlistResponse.fromJson(json.decode(str));

String wishlistResponseToJson(WishlistResponse data) => json.encode(data.toJson());

class WishlistResponse {
  bool? success;
  String? msg;
  List<Datum>? data;

  WishlistResponse({
    this.success,
    this.msg,
    this.data,
  });

  factory WishlistResponse.fromJson(Map<String, dynamic> json) => WishlistResponse(
    success: json["success"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  User? user;
  Product? product;

  Datum({
    this.id,
    this.user,
    this.product,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    user: User.fromJson(json["user"]),
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user?.toJson(),
    "product": product?.toJson(),
  };
}

class Product {
  String? id;
  String? name;
  String? sku;
  List<dynamic>? images;
  num? price;

  Product({
    this.id,
    this.name,
    this.sku,
    this.images,
    this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    name: json["name"],
    sku: json["sku"],
    images: List<dynamic>.from(json["images"].map((x) => x)),
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "sku": sku,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "price": price,
  };
}

class User {
  String? id;
  String? name;
  String? email;
  String? mobileNo;

  User({
    this.id,
    this.name,
    this.email,
    this.mobileNo,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    mobileNo: json["mobile_no"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "mobile_no": mobileNo,
  };
}
