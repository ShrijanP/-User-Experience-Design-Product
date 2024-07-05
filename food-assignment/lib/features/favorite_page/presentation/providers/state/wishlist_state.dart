// import 'package:ecommerce_assignment/shared/domain/models/cart/my_cart_response.dart';
// import 'package:ecommerce_assignment/shared/domain/models/wishlist/my_wishlist_response.dart';
// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';
import 'package:food_assignment/features/shared/domain/models/wishlist/my_wishlist_response.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_state.freezed.dart';

@freezed
abstract class WishlistState with _$WishlistState {
  const factory WishlistState.initial() = Initial;
  const factory WishlistState.loading() = Loading;
  const factory WishlistState.failure(AppException exception, WishlistResponse data) = Failure;
  const factory WishlistState.success(WishlistResponse data) = Success;
}
