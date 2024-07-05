
// import 'package:ecommerce_assignment/shared/domain/models/order/my_order_response.dart';
// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';
import 'package:food_assignment/features/shared/domain/models/category/category_response.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// import '../../../../../shared/domain/models/category/category_response.dart';

part 'category_state.freezed.dart';

@freezed
abstract class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = Initial;
  const factory CategoryState.loading() = Loading;
  const factory CategoryState.failure(AppException exception, CategoryResponse data) = Failure;
  const factory CategoryState.success(CategoryResponse data) = Success;
}
