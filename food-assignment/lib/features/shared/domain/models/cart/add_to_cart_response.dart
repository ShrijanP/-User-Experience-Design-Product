// To parse this JSON data, do
//
//     final addToCartResponse = addToCartResponseFromJson(jsonString);

import 'dart:convert';

AddToCartResponse addToCartResponseFromJson(String str) => AddToCartResponse.fromJson(json.decode(str));

String addToCartResponseToJson(AddToCartResponse data) => json.encode(data.toJson());

class AddToCartResponse {
  bool? success;
  String? msg;
  Data? data;

  AddToCartResponse({
    this.success,
    this.msg,
    this.data,
  });

  factory AddToCartResponse.fromJson(Map<String, dynamic> json) => AddToCartResponse(
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
  CartItem? cartItem;

  Data({
    this.cart,
    this.cartItem,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cart: Cart.fromJson(json["cart"]),
    cartItem: CartItem.fromJson(json["cartItem"]),
  );

  Map<String, dynamic> toJson() => {
    "cart": cart?.toJson(),
    "cartItem": cartItem?.toJson(),
  };
}

class Cart {
  String? id;
  num? cartNo;
  String? userId;
  num? total;
  num? discount;
  num? grandTotal;
  bool? isActive;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  Cart({
    this.id,
    this.cartNo,
    this.userId,
    this.total,
    this.discount,
    this.grandTotal,
    this.isActive,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["_id"],
    cartNo: json["cart_no"],
    userId: json["user_id"],
    total: json["total"],
    discount: json["discount"],
    grandTotal: json["grand_total"],
    isActive: json["is_active"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "cart_no": cartNo,
    "user_id": userId,
    "total": total,
    "discount": discount,
    "grand_total": grandTotal,
    "is_active": isActive,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class CartItem {
  String? item;
  String? variant;
  num? price;
  num? quantity;
  String? status;
  bool? isActive;
  String? cart;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CartItem({
    this.item,
    this.variant,
    this.price,
    this.quantity,
    this.status,
    this.isActive,
    this.cart,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    item: json["item"],
    variant: json["variant"],
    price: json["price"],
    quantity: json["quantity"],
    status: json["status"],
    isActive: json["is_active"],
    cart: json["cart"],
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "item": item,
    "variant": variant,
    "price": price,
    "quantity": quantity,
    "status": status,
    "is_active": isActive,
    "cart": cart,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
