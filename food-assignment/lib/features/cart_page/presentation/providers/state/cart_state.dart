// import 'package:ecommerce_assignment/shared/domain/models/cart/my_cart_response.dart';
// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/models/cart/my_cart_response.dart';
import '../../../../shared/exceptions/http_exception.dart';

part 'cart_state.freezed.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState.initial() = Initial;
  const factory CartState.loading() = Loading;
  const factory CartState.failure(AppException exception, MyCartResponse data) = Failure;
  const factory CartState.success(MyCartResponse data) = Success;
}
