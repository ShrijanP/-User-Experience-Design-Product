// // To parse this JSON data, do
// //
// //     final myCartResponse = myCartResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// MyCartResponse myCartResponseFromJson(String str) => MyCartResponse.fromJson(json.decode(str));
//
// String myCartResponseToJson(MyCartResponse data) => json.encode(data.toJson());
//
// class MyCartResponse {
//   bool? success;
//   String? msg;
//   Data? data;
//
//   MyCartResponse({
//     this.success,
//     this.msg,
//     this.data,
//   });
//
//   factory MyCartResponse.fromJson(Map<String, dynamic> json) => MyCartResponse(
//     success: json["success"],
//     msg: json["msg"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "msg": msg,
//     "data": data?.toJson(),
//   };
// }
//
// class Data {
//   Cart? cart;
//   List<CartItem>? cartItems;
//
//   Data({
//     this.cart,
//     this.cartItems,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     cart: Cart.fromJson(json["cart"]),
//     cartItems: List<CartItem>.from(json["cartItems"].map((x) => CartItem.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "cart": cart?.toJson(),
//     "cartItems": List<dynamic>.from(cartItems!.map((x) => x.toJson())),
//   };
// }
//
// class Cart {
//   String? id;
//   num? cartNo;
//   UserId? userId;
//   num? total;
//   num? discount;
//   num? grandTotal;
//   String? status;
//
//   Cart({
//     this.id,
//     this.cartNo,
//     this.userId,
//     this.total,
//     this.discount,
//     this.grandTotal,
//     this.status,
//   });
//
//   factory Cart.fromJson(Map<String, dynamic> json) => Cart(
//     id: json["_id"],
//     cartNo: json["cart_no"],
//     userId: UserId.fromJson(json["user_id"]),
//     total: json["total"],
//     discount: json["discount"],
//     grandTotal: json["grand_total"],
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "cart_no": cartNo,
//     "user_id": userId?.toJson(),
//     "total": total,
//     "discount": discount,
//     "grand_total": grandTotal,
//     "status": status,
//   };
// }
//
// class UserId {
//   String? id;
//   String? name;
//   String? email;
//   num? contact;
//   String? address;
//
//   UserId({
//     this.id,
//     this.name,
//     this.email,
//     this.contact,
//     this.address,
//   });
//
//   factory UserId.fromJson(Map<String, dynamic> json) => UserId(
//     id: json["_id"],
//     name: json["name"],
//     email: json["email"],
//     contact: json["contact"],
//     address: json["address"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "name": name,
//     "email": email,
//     "contact": contact,
//     "address": address,
//   };
// }
//
// class CartItem {
//   String? id;
//   Item? item;
//   dynamic variant;
//   num? price;
//   num? quantity;
//   List<String>? images;
//
//   CartItem({
//     this.id,
//     this.item,
//     this.variant,
//     this.price,
//     this.quantity,
//     this.images,
//   });
//
//   factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
//     id: json["_id"],
//     item: Item.fromJson(json["item"]),
//     variant: json["variant"],
//     price: json["price"],
//     quantity: json["quantity"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "item": item?.toJson(),
//     "variant": variant,
//     "price": price,
//     "quantity": quantity,
//   };
// }
//
// class Item {
//   String? id;
//   String? productName;
//   String? productSku;
//   dynamic variant;
//   List<String>? images;
//
//   Item({
//     this.id,
//     this.productName,
//     this.productSku,
//     this.variant,
//     this.images,
//   });
//
//   factory Item.fromJson(Map<String, dynamic> json) => Item(
//     id: json["_id"],
//     productName: json["product_name"],
//     productSku: json["product_sku"],
//     variant: json["variant"],
//     images: List<String>.from(json["images"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "product_name": productName,
//     "product_sku": productSku,
//     "variant": variant,
//     "images": List<dynamic>.from(images!.map((x) => x)),
//   };
// }
//


// To parse this JSON data, do
//
//     final myCartResponse = myCartResponseFromJson(jsonString);

import 'dart:convert';

MyCartResponse myCartResponseFromJson(String str) => MyCartResponse.fromJson(json.decode(str));

String myCartResponseToJson(MyCartResponse data) => json.encode(data.toJson());

class MyCartResponse {
  bool? success;
  String? msg;
  Data? data;

  MyCartResponse({
    this.success,
    this.msg,
    this.data,
  });

  factory MyCartResponse.fromJson(Map<String, dynamic> json) => MyCartResponse(
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
  Cart? cart;
  List<CartItem>? cartItems;

  Data({
    this.cart,
    this.cartItems,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cart: Cart.fromJson(json["cart"]),
    cartItems: List<CartItem>.from(json["cartItems"].map((x) => CartItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cart": cart?.toJson(),
    "cartItems": List<dynamic>.from(cartItems!.map((x) => x.toJson())),
  };
}

class Cart {
  String? id;
  num? cartNo;
  UserId? userId;
  num? total;
  num? discount;
  num? grandTotal;
  String? status;

  Cart({
    this.id,
    this.cartNo,
    this.userId,
    this.total,
    this.discount,
    this.grandTotal,
    this.status,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["_id"],
    cartNo: json["cart_no"],
    userId: UserId.fromJson(json["user_id"]),
    total: json["total"],
    discount: json["discount"],
    grandTotal: json["grand_total"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "cart_no": cartNo,
    "user_id": userId?.toJson(),
    "total": total,
    "discount": discount,
    "grand_total": grandTotal,
    "status": status,
  };
}

class UserId {
  String? id;
  String? name;
  String? email;
  String? mobileNo;

  UserId({
    this.id,
    this.name,
    this.email,
    this.mobileNo,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
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

class CartItem {
  String? id;
  Item? item;
  int? price;
  int? quantity;

  CartItem({
    this.id,
    this.item,
    this.price,
    this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json["_id"],
    item: Item.fromJson(json["item"]),
    price: json["price"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "item": item?.toJson(),
    "price": price,
    "quantity": quantity,
  };
}

class Item {
  String? id;
  String? name;
  String? sku;
  List<String>? images;
  num? price;
  num? rating;

  Item({
    this.id,
    this.name,
    this.sku,
    this.images,
    this.price,
    this.rating,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["_id"],
    name: json["name"],
    sku: json["sku"],
    images: List<String>.from(json["images"].map((x) => x)),
    price: json["price"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "sku": sku,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "price": price,
    "rating": rating,
  };
}
