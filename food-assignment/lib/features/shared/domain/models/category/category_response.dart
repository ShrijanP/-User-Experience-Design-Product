// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

CategoryResponse categoryResponseFromJson(String str) => CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) => json.encode(data.toJson());

class CategoryResponse {
  bool? success;
  String? msg;
  List<Datum>? data;
  int? page;
  int? size;
  int? totalCount;

  CategoryResponse({
    this.success,
    this.msg,
    this.data,
    this.page,
    this.size,
    this.totalCount,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
    success: json["success"],
    msg: json["msg"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    page: json["page"],
    size: json["size"],
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "page": page,
    "size": size,
    "totalCount": totalCount,
  };
}

class Datum {
  String? id;
  String? name;
  int? order;
  String? image;
  DateTime? createdAt;
  String? datumId;
  num? product_count;

  Datum({
    this.id,
    this.name,
    this.order,
    this.createdAt,
    this.datumId,
    this.image,
    this.product_count
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    name: json["name"],
    image: json["image"],
    product_count: json["product_count"],
    order: json["order"],
    createdAt: DateTime.parse(json["createdAt"]),
    datumId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
    "order": order,
    "product_count": product_count,
    "createdAt": createdAt?.toIso8601String(),
    "id": datumId,
  };
}
