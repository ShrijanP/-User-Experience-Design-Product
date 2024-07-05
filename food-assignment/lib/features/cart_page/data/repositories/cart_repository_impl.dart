import 'package:food_assignment/features/shared/domain/models/cart/my_cart_response.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/user/user_model.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

import '../../../../features/shared/domain/models/cart/add_to_cart_response.dart';
import '../../../../features/shared/domain/models/common_response.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasource/cart_remote_data_source.dart';

class CartRepositoryImpl extends CartRepository {
  final CartDataSource dataSource;

  CartRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, AddToCartResponse>> addToCart({required Map<String, dynamic> requestData}) {
    return dataSource.addToCart(requestData: requestData);
  }

  @override
  Future<Either<AppException, MyCartResponse>> fetchMyCart() {
    return dataSource.fetchMyCart();
  }

  @override
  Future<Either<AppException, CommonResponse>> removeCart({required Map<String, dynamic> requestData}) {
    return dataSource.removeCart(requestData: requestData);
  }

  @override
  Future<Either<AppException, CommonResponse>> checkOut({required String requestData, required String id}) {
    return dataSource.checkOut(requestData: requestData, id: id);
  }

}
