import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

typedef ProductList = List<Product>;

@freezed
class Product with _$Product {
  factory Product({
    @Default('') String id,
    @Default('') String name,
    @Default('') String sku,
    @Default('') String description,
    @Default(0) num calorie_count,
    @Default(0) num rating,
    @Default(0) num price,
    @Default([]) List<String> images,
  }) = _Product;

  factory Product.fromJson(dynamic json) => _$ProductFromJson(json);
}
