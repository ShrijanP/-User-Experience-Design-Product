// To parse this JSON data, do
//
//     final myOrderResponse = myOrderResponseFromJson(jsonString);

import 'dart:convert';

MyOrderResponse myOrderResponseFromJson(String str) =>
    MyOrderResponse.fromJson(json.decode(str));

String myOrderResponseToJson(MyOrderResponse data) =>
    json.encode(data.toJson());

class MyOrderResponse {
  bool? success;
  String? msg;
  List<Datum>? data;

  MyOrderResponse({
    this.success,
    this.msg,
    this.data,
  });

  factory MyOrderResponse.fromJson(Map<String, dynamic> json) =>
      MyOrderResponse(
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
  Item? item;
  num? price;
  num? quantity;
  String? status;
  bool? isActive;
  String? cart;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  Datum({
    this.id,
    this.item,
    this.price,
    this.quantity,
    this.status,
    this.isActive,
    this.cart,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        item: Item.fromJson(json["item"]),
        price: json["price"],
        quantity: json["quantity"],
        status: json["status"],
        isActive: json["is_active"],
        cart: json["cart"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "item": item?.toJson(),
        "price": price,
        "quantity": quantity,
        "status": status,
        "is_active": isActive,
        "cart": cart,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Item {
  String? id;
  String? name;
  String? description;
  String? category;
  String? productSku;
  num? price;
  List<String>? images;

  Item({
    this.id,
    this.name,
    this.description,
    this.category,
    this.productSku,
    this.price,
    this.images,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        category: json["category"],
        productSku: json["product_sku"],
        price: json["price"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "category": category,
        "product_sku": productSku,
        "price": price,
        "images": List<dynamic>.from(images!.map((x) => x)),
      };
}
