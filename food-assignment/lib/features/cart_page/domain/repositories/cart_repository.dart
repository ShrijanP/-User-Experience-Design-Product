import 'package:food_assignment/features/shared/domain/models/cart/my_cart_response.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

import '../../../../features/shared/domain/models/cart/add_to_cart_response.dart';
import '../../../../features/shared/domain/models/common_response.dart';

abstract class CartRepository {
  Future<Either<AppException, AddToCartResponse>> addToCart({required Map<String, dynamic> requestData});
  Future<Either<AppException, MyCartResponse>> fetchMyCart();
  Future<Either<AppException, CommonResponse>> removeCart({required Map<String, dynamic> requestData});
  Future<Either<AppException, CommonResponse>> checkOut({required String requestData, required String id});
}
