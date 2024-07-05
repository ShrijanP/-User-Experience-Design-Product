// To parse this JSON data, do
//
//     final allProductResponse = allProductResponseFromJson(jsonString);

import 'dart:convert';

AllProductResponse allProductResponseFromJson(String str) => AllProductResponse.fromJson(json.decode(str));

String allProductResponseToJson(AllProductResponse data) => json.encode(data.toJson());

class AllProductResponse {
  bool? success;
  String? msg;
  List<Datum>? data;

  AllProductResponse({
    this.success,
    this.msg,
    this.data,
  });

  factory AllProductResponse.fromJson(Map<String, dynamic> json) => AllProductResponse(
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
  String? category;
  String? productSku;
  List<Variant>? variant;

  Datum({
    this.id,
    this.category,
    this.productSku,
    this.variant,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    category: json["category"],
    productSku: json["product_sku"],
    variant: List<Variant>.from(json["variant"].map((x) => Variant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "category": category,
    "product_sku": productSku,
    "variant": List<dynamic>.from(variant!.map((x) => x.toJson())),
  };
}

class Variant {
  String? sku;
  int? stock;
  List<VariantType>? variantType;
  int? price;
  List<dynamic>? images;
  String? id;

  Variant({
    this.sku,
    this.stock,
    this.variantType,
    this.price,
    this.images,
    this.id,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    sku: json["sku"],
    stock: json["stock"],
    variantType: List<VariantType>.from(json["variant_type"].map((x) => VariantType.fromJson(x))),
    price: json["price"],
    images: List<dynamic>.from(json["images"].map((x) => x)),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "sku": sku,
    "stock": stock,
    "variant_type": List<dynamic>.from(variantType!.map((x) => x.toJson())),
    "price": price,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "_id": id,
  };
}

class VariantType {
  String? size;
  String? color;
  String? id;

  VariantType({
    this.size,
    this.color,
    this.id,
  });

  factory VariantType.fromJson(Map<String, dynamic> json) => VariantType(
    size: json["size"],
    color: json["color"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "size": size,
    "color": color,
    "_id": id,
  };
}
